## Home of https://hub.docker.com/r/eqmacemu/eqmacemu


This docker image represents a fully configured and ready to play EQMac Emu Server
  * https://github.com/EQMacEmu/Server
  * https://www.takproject.net/


The purpose of this image is to quickly stand up a TAKP server. This is not a development environment, if you're interested in modifying the source then visit https://github.com/EQMacEmu/Server/tree/main/.devcontainer for information on a dockerized development environment. This is not recommended, nor configured properly, for production/public use.

&nbsp;
&nbsp;

--- 
## How to Run the Server
1. On Windows - Download "Docker Desktop" https://docs.docker.com/desktop/install/windows-install/ 

2. Open a Windows "Command Prompt" and execute these 2 commands.

  ```
  docker volume create eqmacemu-data
  ```

  ```
  docker run -d -v eqmacemu-data:/var/lib/mysql -p 6000:6000/udp -p 5998:5998 -p 9000:9000/udp -p 9000:9000 -p 7778:7778/udp -p 7375-7400:7375-7400/udp -p 7375-7400:7375-7400 -p 7000-7374:7000-7374/udp -p 7000-7374:7000-7374 -p 3306:3306 eqmacemu/eqmacemu:latest
  ```

3. Ensure your EQ Client's eqhosts.txt file points to your local server. Get the client from https://wiki.takp.info/index.php/Getting_Started if you do not already have it.

```
[Registration Servers]
{
"127.0.0.1:6000"
}
[Login Servers]
{
"127.0.0.1:6000"
}
```

4. Login with any username/password, the first login will require username/password twice.

5. Read the additional information.

&nbsp;
&nbsp;

---

## Additional Information

- Make yourself gm by executing this command; be sure to replace XXX with the account name you used in Step 4. Logging in and out is required.
```
docker exec -it my-eqmacemu mysql -e "UPDATE account SET status=255 WHERE name = 'XXX'" peq
```

- Don't lose your database! The database is mounted to a docker volume. You can use "Docker Desktop" Volume tab to see it (it is named eqmacemu-data). If you remove/delete this volume your database will be destroyed.

- If you wish to stop the server you can just completely exit "Docker Desktop", or visit the "Containers" tab and select the "Stop" button next to my-eqmacemu.

- If you wish to resume the server after exiting "Docker Desktop", or by stopping the container, you can visit the "Containers" tab in "Docker Desktop" and select the "Play" button.

- If you wish to start fresh, you can remove the container under the "Containers" tab, the image under the "Images" tab, and the database under the "Volumes" tab and start at Step 1.

&nbsp;
&nbsp;

