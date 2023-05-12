# Acerca de Productito
Productito es una API construida 100% en Rack para el challenge de Ruby de FUDO.

## Correr la app en development
Usando Docker, podes levantar la API usando los siguientes comandos:
```
docker build -t productito .
docker run -p 9292:9292 -e RACK_ENV=development productito
```

## Cómo usar la API

### Autenticación

Lo primero y más importante es que todos los endpoints de la API se encuentran protegidos con BasicAuth, lo que significa que tenemos que enviar un usuario y contraseña encodeados en Base64 en el header `Authorization`, en cada request que hagamos. Consideré usar JWT, que es una opción superadora a BasicAuth ya que nos permitiría manejar tokens por usuario, definir TTL de los mismos, etc, pero me decanté por esta última ya que es más simple de implementar.

Hay un solo usuario y contraseña por lo que no tenemos autorización basada en usuarios ni roles, pero podría agregarse en un futuro. El usuario y contraseña se define a través de variables de entorno `BASE_USER` y `BASE_PASSWORD`.

### Persistencia

Para hacerlo un poco más divertido y funcional, implementamos persistencia usando un patrón `ActiveRecord` similar a como hace Rails. Por ahora, almacenamos los datos de cada modelo en un archivo `JSON` que el `JSONAdapter` se encarga de actualizar.

### Endpoints

En esta versión de la API, solamente podemos realizar las siguientes dos acciones:

1. Consultar todos los productos
2. Crear productos nuevos

En el futuro, se podría facilmente agregar funcionalidad para completar el CRUD: update, show y delete.

Les dejo dos comandos usando `curl` para ilustrar como se puede usar la API hoy por hoy:

**Crear un producto**
```
curl http://localhost:9292/products -X POST -u "nacho:secret_password" -H "Content-Type: application/json" -d '{"price":"30.35", "name": "test_product"}'
```

**Consultar todos los productos**
```
curl http://localhost:9292/products -u nacho:secret_password
```

**La api tambien puede aplicar compresion si enviamos el header Accept-Encoding: gzip**
```
curl --compressed http://localhost:9292/products -u nacho:secret_password
```

La creación de productos se hace de manera asincrónica luego de 5 segundos. Está implementada de forma tal que ese delay de 5 segundos no bloquee el procesamiento de otros requests, a través de la interfaz de threading de Ruby:

Request #1 de Creación de producto "Manzana" => Se crea un nuevo Thread, se setea un delay de 5 segundos y se devuelve el control al thread principal que procesa requests de manera inmediata => Se devuelve una response indicando que se está procesando la creación => Pasan los 5 segundos y el thread que maneja la creación del producto retoma el control, persiste el producto y escribe un log a STDOUT


## FAQ

**¿Por qué el mix entre inglés y español?**

En mis trabajos anteriores, toda la documentación estaba en inglés, excepto la que apuntaba a usuarios de negocio hispanoparlantes. La idea de tener tanto el código como la documentación en inglés era poder sumar desarrolladores que hablaran otras lenguas al equipo de una forma más sencilla.
En este proyecto, seguí con esa línea por costumbre, por eso los PRs y el código están en inglés.

**¿Donde encuentro las respuestas al punto 1, 2 y 3?

Podes encontrarlas en el directorio `docs/`.

**¿Cómo se te ocurre usar BasicAuth en una app que no fuerza HTTPS?**

Para una aplicación productiva real, usaría algún patrón de autenticación más robusto como JWT o Cookie-based Auth y sobre todo, me aseguraría de:

1. Transmitir todo el tráfico sobre HTTPS y upgradear todas las conexiones de HTTP a HTTPS.
2. Firmar los tokens/cookies con un secret del lado del servidor.

En el diseño actual, las credenciales se mandan a través de HTTP codificadas en Base64. Para un atacante, es trivial capturar esos paquetes y obtener las credenciales ya que están en texto plano.
