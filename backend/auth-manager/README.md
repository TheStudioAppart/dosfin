# Authentication Manager

## Structure

- **`index.js`** # microservice
- **`config/`**
    - microservice-config.json
    - database.json
- **`plugin-manager/`** (auth, group, user)
    - `handlers/` # each handler reference a API route [1-1]
    - `communicator.js` # declare all MS requests which the current MS can use.
    - `data-access.js` # hemera-store, call a sql MS who write in the DB.
    - `index.js` # load the commicator, data-access and the manager.
    - `manager.js` # load handlers, name them and attach to each handler the communicator and the d-a.

## auth-manager

Handle authentication by token...

- role: `auth`, cmd: `none`

## group-manager

Handle user groups...

- role: `group`, cmd: `none`

## user-manager

Handle users...

- role: `user`, cmd: `none`