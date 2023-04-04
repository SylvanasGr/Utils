<h1>Encrypting and Decrypting Sensitive Information in a Spring Boot Application</h1>

<h2>Encryption</h2>
<strong>mvn jasypt:encrypt '-Djasypt.encryptor.password=YOUR_PASSWORD' '-Djasypt.plugin.path=file:
PATH_TO_CONFIG_FILE'</strong>

<p>This command encrypts sensitive information in a Spring Boot configuration file using Jasypt encryption, with the password specified as a Maven system property.</p>

<h2>Decryption</h2>
<strong>mvn jasypt:decrypt '-Djasypt.encryptor.password=YOUR_PASSWORD' '-Djasypt.plugin.path=file:
PATH_TO_CONFIG_FILE'</strong>

<p>This command decrypts the encrypted information in a Spring Boot configuration file using Jasypt decryption, with the password specified as a Maven system property.</p>

<p>Replace <strong>YOUR_PASSWORD</strong> with your encryption password and <strong>PATH_TO_CONFIG_FILE</strong> with the path to your configuration file.</p>

