"use strict";
const express = require('express');
const router = express.Router();
const app = express();
const bodyParser = require('body-parser');
const db = require('./database');
const watson = require('watson-developer-cloud');
const guias = db.collection('guias');
const usuarios = db.collection('usuarios');


const language_translation = watson.language_translation({
    url: "https://gateway.watsonplatform.net/language-translation/api",
    password: "HAFA237C1iUV",
    username: "e57948ce-2d12-4208-93e2-3f05dafc97da",
    version: 'v2'
});

const tone_analyzer = watson.tone_analyzer({

    url: "https://gateway.watsonplatform.net/tone-analyzer/api",
    password: "quCbVljSyT0u",
    username: "b191b042-1f57-43cc-87b7-86d4f4f9c7ba",
    version: 'v3',
    version_date: '2016-05-19 '
});


var personalityInsights = watson.personality_insights({
    username: '4e754f0d-edc4-4f9a-ba08-d10e835b5a5e',
    password: 'mA24SKSq8d73',
    version: 'v2'
});

// guias.remove({}, () => {

// });
class GuiaController {
    cadastrar(req, res) {
        var dados = req.body;
        const model = new Promise((reject, resolve) => {
            guias.insert(dados, (err, res) => {
                if (err) return reject(err);
                console.log(`registro ${JSON.stringify(res)} inserido com sucesso`);
                return resolve(res);
            });
        });
    }
    obterPorId(_id) {
        const model = new Promise((reject, resolve) => {
            guias.findOne({ "_id": mongo.ObjectId(_id) }, (err, res) => {
                if (err) return reject(err);
                console.log(`registro ${JSON.stringify(res)} inserido com sucesso`);
                return resolve(res);
            });
        });
    }
    listar(req, res) {
        guias.find({}, (err, result) => {
            if (err) res.json([]);
            result.map((item) => {
                let that = this;
                let recommendations = item.recommendations;
                recommendations = recommendations.map((rec) => {
                    console.log('comments', rec.comments);
                    console.log('that', that);

                    language_translation.translate({
                        text: rec.comments,
                        source: 'pt-br',
                        target: 'en'
                    },
                        (err, translation) => {
                            if (err) console.log(err)
                            else {
                                const texto = (translation.translations[0] || 0).translation;
                                console.log('texto', texto);

                                tone_analyzer.tone({ text: texto },
                                    function (err, tone) {
                                        if (err)
                                            console.log(err);
                                        else {

                                            // var tones = (tone.tone_categories[0] || 0).tones || [];
                                            // var tone = tones.filter((filt) => {
                                            //     return filt.tone_id === "joy";
                                            // });
                                            // return tone.score;
                                            return texto;
                                        }
                                    });
                            }
                            console.log(translation);
                        });



                });
            });


            return res.json(result);
        });



    }

}
 
class UsuarioController {
    cadastrar(req, res) {
        const dados = req.body;
        const model = new Promise((reject, resolve) => {
            usuarios.insert(dados, (err, res) => {
                if (err) return reject(err);
                console.log(`registro ${JSON.stringify(res)} inserido com sucesso`);
                return resolve(res);
            });
        });
    }
    obterPorId(id) {
        const model = new Promise((reject, resolve) => {
            usuarios.findOne({ "_id": mongo.ObjectId(id) }, (err, res) => {
                if (err) return reject(err);
                console.log(`registro ${JSON.stringify(res)} inserido com sucesso`);
                return resolve(res);
            });
        });
    }

}

router.get('/usuarios', new UsuarioController().cadastrar);
router.get('/guias', new GuiaController().listar);

app.use('/', router);
app.use(bodyParser.json());
app.get('/', (req, res) => {
    res.json({ 'test': 'success' });
});
var port = process.env.PORT || 8080;
app.listen(port, () => {
    console.log('Running.. on ' + port);
});


