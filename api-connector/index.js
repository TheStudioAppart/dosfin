/* Copyrith 2018 (c)  by Audren Guillaume (Alaktos) */

const fs = require('fs');

const Hapi = require('hapi');
const HapiHemera = require('hapi-hemera');
const HapiSwagger = require('hapi-swagger');
const HapiAuth = require('hapi-auth-bearer-token');
const HapiRbac = require('hapi-rbac');

const Vision = require('vision');
const Inert = require('inert');

const HemeraJoi = require('hemera-joi');

// Configuration
const { api, hemera, nats, plugins, swagger } = require('./config/server');

const server = new Hapi.server(api);


/* Authentication --------------------------------------------------------------------------------------------------- */

// TODO

/* Main function ---------------------------------------------------------------------------------------------------- */

const start = async () => {

    /* plugins registration */

    // TODO
    // await server.register(HapiAuth);
    // await server.register(HapiRbac);
    // server.auth.strategy('token', 'token', { validate });
    // server.auth.default('token');

    /* add Hemera plugin to Hapi */
    await server.register({
        plugin: HapiHemera,
        options: {
            hemera: hemera,
            nats: nats
        }
    });

    /* Add Swagger plugin to Hapi */
    await server.register([
        Vision,
        Inert,
        { plugin: HapiSwagger, options: swagger }
    ]);

    /* import routes */
    let routes = fs.readdirSync('./routes', 'utf8');
    routes.forEach(r => server.route(require(`./routes/${r}`)));

    /* start server */
    await server.start();
}

/* run server */

start()
    .then(() => console.log(`Server is running at: ${server.info.uri}`))
    .catch((err) => console.log(err));

// natsboard --port XXXX (default 8222)
// pm2 complete
