const Hp = require('hemera-plugin');

const Manager = require('./manager');
const cfg = require('../config/database');

function hemeraGroup(hemera, opts, done) {
    const {topic, store} = opts;
    const {collection} = cfg;
    const {joi} = hemera;

    const manager = Manager(hemera, opts);

    /* public -------------------------------------------------------------- */
    Object.keys(manager).map(cmd => hemera.add({topic, cmd}, manager[cmd]));

    done();
}

module.exports = Hp(hemeraGroup, {
    hemera: '>=6',
    name: require('./package.json').name,
    options: {}
})
