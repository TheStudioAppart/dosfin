const joi = require('joi');


module.exports = [
    { /* POST /auth */
        method: 'POST',
        path: '/login',
        config: {
            auth: false,
            description: 'Authentication route, [email/password]',
            tags: ['api', 'auth'],
            validate: {
                payload: {
                    email: joi.string().email().required(),
                    password: joi.string().required()
                }
            }
        },
        handler: async (request, h) => {
            return request.hemera.act({
                topic: 'auth-manager',
                cmd: 'login',
                query: request.payload
            });
        }
    },
    { /* POST /auth */
        method: 'POST',
        path: '/createaccount',
        config: {
            auth: false,
            description: 'account creation',
            tags: ['api', 'auth'],
            validate: {
                payload: joi.object({
                    email: joi.string().email().required(),
                    password: joi.string().required(),
                    confirmpassword: joi.string().required(),
                    nom: joi.string().required(),
                    prenom: joi.string().required()
                })
            }
        },
        handler: async (request, h) => {
            return request.hemera.act({
                topic: 'auth-manager',
                cmd: 'createaccount',
                query: request.payload
            });
        }
    },
    { /* POST /auth */
        method: 'POST',
        path: '/validateaccount',
        config: {
            auth: false,
            description: 'account validation route',
            tags: ['api', 'auth'],
            validate: {
                payload: {

                    userid: joi.number().integer().required(),
                    groupid: joi.number().integer().required()
                }
            }
        },
        handler: async (request, h) => {
            return request.hemera.act({
                topic: 'auth-manager',
                cmd: 'validateaccount',
                query: request.payload
            });
        }
    }
    { /* POST /auth */
        method: 'POST',
        path: '/logout',
        config: {
            auth: false,
            description: 'logout route',
            tags: ['api', 'auth'],

        },
        handler: async (request, h) => {
            return request.hemera.act({
                topic: 'auth-manager',
                cmd: 'logout',
                query: request.payload
            });
        }
    }


]const joi = require('joi');


module.exports = [
    { /* POST /auth */
        method: 'POST',
        path: '/login',
        config: {
            auth: false,
            description: 'Authentication route, [email/password]',
            tags: ['api', 'auth'],
            validate: {
                payload: {
                    email: joi.string().email().required(),
                    password: joi.string().required()
                }
            }
        },
        handler: async (request, h) => {
            return request.hemera.act({
                topic: 'auth-manager',
                cmd: 'login',
                query: request.payload
            });
        }
    },
    { /* POST /auth */
        method: 'POST',
        path: '/createaccount',
        config: {
            auth: false,
            description: 'account creation',
            tags: ['api', 'auth'],
            validate: {
                payload: joi.object({
                    email: joi.string().email().required(),
                    password: joi.string().required(),
                    confirmpassword: joi.string().required(),
                    nom: joi.string().required(),
                    prenom: joi.string().required()
                })
            }
        },
        handler: async (request, h) => {
            return request.hemera.act({
                topic: 'auth-manager',
                cmd: 'createaccount',
                query: request.payload
            });
        }
    },
    { /* POST /auth */
        method: 'POST',
        path: '/validateaccount',
        config: {
            auth: false,
            description: 'account validation route',
            tags: ['api', 'auth'],
            validate: {
                payload: {

                    userid: joi.number().integer().required(),
                    groupid: joi.number().integer().required()
                }
            }
        },
        handler: async (request, h) => {
            return request.hemera.act({
                topic: 'auth-manager',
                cmd: 'validateaccount',
                query: request.payload
            });
        }
    }
    { /* POST /auth */
        method: 'POST',
        path: '/logout',
        config: {
            auth: false,
            description: 'logout route',
            tags: ['api', 'auth'],

        },
        handler: async (request, h) => {
            return request.hemera.act({
                topic: 'auth-manager',
                cmd: 'logout',
                query: request.payload
            });
        }
    }


]