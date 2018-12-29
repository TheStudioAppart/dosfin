const Hemera = require('nats-hemera');
const Nats = require('nats');

const HemeraJoi = require('hemera-joi');
const HemeraStore = require('hemera-mysql-store');

const cfg = require('./config/auth-config');
const { logLevel, knex, nats, pluginName, topic} = cfg;
const { url, host, port, user, pass } = nats;

// message server
const client = Nats.connect({ url: url || `nats://${host}:${port}` });

const hemera = new Hemera(client, {
    logLevel,
    childLogger: false,
    tag: topic
});

const plugin = require(`./${topic}`);

hemera.use(HemeraJoi);
hemera.use(HemeraStore, { knex });
hemera.use(plugin, cfg);

hemera
    .ready()
    .then(() => console.log(`${pluginName} service listening...`))
    .catch((err) => console.error(err, `${pluginName} service error!`));