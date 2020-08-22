# delilah_resto
Api desarrollada para ser utilizada por un delivery de comidas.

### Instalaciones requeridas:
- Postman
- NodeJs
- Visual Studio Code 
- MySQL Workbench

### Pasos a seguir:

1 - Ejecutar el siguiente comando desde la carpeta del proyecto:
   ```npm i bcrypt body-parser dotenv express jsonwebtoken mysql2 nodemon```

2 - Copiar el contenido del archivo db.sql que está en la carpeta database y ejecutarlo en MySql Workbench.

3 - Configurar las variables de entorno del archivo .env, por ejemplo:
    APP_PORT=3000     (puerto que va a usar la api)
    DB_PORT=3306      (puerto configurado en su servidor de base de datos)
    DB_HOST=localhost (ip o dirección de la aplicacion del servidor de la api)
    DB_USER=root      (usuario configurado en su servidor de base de datos)
    DB_PASS=1234      (la contraseña de su usuario)
    MYSQL_DB=delilah  (nombre de la base de datos)
    JWT_SECRET=secret (se usa para obtener los jsonwebtoken para el login)

4 - Ejecutar:
    ```npm start```

5- Desde Postman escribir las rutas con sus correspondientes recursos (GET, POST, PUT, DELETE). 

Se requiere enviar los token recibidos en el login a través de la pestaña 
Authorization, seleccionando el type "Bearer Token" y escribiendo solo el token que ha sido recibido,
por ejemplo:
```         eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZXN1bHQiOnsiaWRfdXNlciI6MiwidXNlcm5hbWUiOiJMZW9uYXJkbyIsInRva2VuIjpudWxsLCJlbWFpbCI6Imxlb0BnbWFpbC5jb20iLCJuYW1lIjoiTGVvbmFyZG8iLCJsYXN0X25hbWUiOiJUdWxpYW4iLCJhZGRyZXNzIjoiQ29sw7NuIDQ1NiIsInBob25lIjoiMTE1NDM1NDM2NSIsImlkX3JvbGUiOjIsImlkX2NpdHkiOjN9LCJpYXQiOjE1OTc5NTYzMjcsImV4cCI6MTU5Nzk1OTkyN30.dBKdaEH25tCvrwgRlCbv00vU4nRIO6leYt3ZV5QN-H4
```

### Rutas:
  
  - ###  Creación de usuarios.
  
  POST /api/user/
  
  BODY:
  ```
  {
	"username":"Andrea",
	"password":"123456",
	"email":"andrea@gmail.com",
	"name":"Andrea",
	"last_name":"Gómez",
	"address":"Calle Falsa 123",
	"phone":"43556776",
	"id_role": 1,
	"id_city": 2
  }
  ```
  En el caso de id_role se admite 1 para admin y 2 para usuario.
  A los usuarios nuevos se les encriptará la contraseña para no guardarse como texto plano.
  
  - ### Loguearse
  
  POST /api/user/login
  
  BODY:
  ```
  {
  "email":"andrea@gmail.com",
	"username":"Andrea",
	"password":"contraseña creada en base de datos"
  }
  ```
  Se puede omitir o el usuario o el mail.
  
  Admin de prueba:
  ```
  {
   "email":"agus@gmail.com",
	 "username":"Agustina",
	 "password":"123456"
  }
  ```
  Usuario de prueba:
  ```
  {
   "email":"leo@gmail.com",
	 "username":"Leonardo",
	 "password":"123456"
  }
  ```
  - ### Obtener todos los usuarios 
  (funcionalidad apta sólo para administradores)
  
  GET /api/user/
  
  No requiere body
  
  - ### Obtener usuario por ID 
  (admins pueden ver información de cualquier id, usuarios pueden ver sólo su información)
  
  GET /api/user/id
  
  BODY:
  ```
  {
	 "id_user": 1
  }
  ```
  
  - ### Obtener todos los productos 
  
  GET /api/product/
  
  No requiere body ni autenticación
  
  - ### Crear un producto 
  (funcionalidad apta sólo para administradores)
  
  POST /api/product/
  
  BODY:
  ```
  {
	 "description": "Ensalada veggie",
	 "price": 340
  }
  ```
  - ### Obtener producto por ID 
  
  GET /api/product/id
  
  BODY:
  ```
  {
    "id_product": 1 
  }
  ```
  - ### Modificar producto por ID (funcionalidad apta sólo para administradores)
  
  PUT /api/product/id
  
  BODY:
  ```
  {
	 "id_product": 2,
	 "description":"Focaccia",
	 "price": 300
  }
  ```
  - ### Eliminar producto (funcionalidad apta sólo para administradores)
  
  DELETE /api/product/id
  
  BODY:
  ```
  {
    "id_product": 2
  }
  ```
  - ### Crear pedido nuevo 
  
  POST /api/order/
  
  BODY:
  ```
  {
	 "id_user": 2,
	 "id_payment": 1,
	 "details":[
      {
        "id_product": 2,
        "quantity" : 1
      },
      {
        "id_product": 1,
        "quantity" : 3
      },
      {
        "id_product": 3,
        "quantity" : 1
      }
    ]
   }
   ```
   - ### Obtener todos los pedidos 
   (funcionalidad apta sólo para administradores)
   
   GET /api/order/
   
   No requiere body.
   
   - ### Modificar estado de un pedido 
   (funcionalidad apta sólo para administradores)
   
   PUT /api/order/id
   
   BODY:
   ```
   {
	  "id_order":14,
	  "id_state":4
   }
   ```
   Siendo los estados:
   1- nuevo
   2- confirmado
   3- preparando
   4- enviando
   5- entregado

   - ### Borrar un pedido
   (funcionalidad apta sólo para administradores)

   DELETE /api/order/id

   BODY:
   ```
   {
	  "id_order": 1
   }
   ```


 
  
  
  
