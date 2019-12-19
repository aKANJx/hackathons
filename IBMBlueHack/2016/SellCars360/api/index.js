var express = require('express');
var bodyParser = require('body-parser');
var request = require('request');
var app = express();
var request = require('request');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.listen((process.env.PORT || 3000));

// Server frontpage
app.get('/', function (req, res) {
    res.send('This is TestBot Server');
});

// Facebook Webhook
app.get('/webhook', function (req, res) {
    if (req.query['hub.verify_token'] === 'testbot_verify_token') {
        res.send(req.query['hub.challenge']);
    } else {
        res.send('Invalid verify token');
    }
});


// handler receiving messages
app.post('/webhook', function (req, res) {
    var events = req.body.entry[0].messaging;
    var event = events[0];
    if (event.message && event.message.text) {
        request.get('http://some.server.com/', ).auth('username', 'password', false);
        if(!carMessage(event.sender.id, event.message.text)) {

        }
    }
    res.sendStatus(200);
});

// generic function sending messages
function sendMessage(recipientId, message) {
    request({
        url: 'https://graph.facebook.com/v2.6/me/messages',
        qs: { access_token: process.env.PAGE_ACCESS_TOKEN },
        method: 'POST',
        json: {
            recipient: { id: recipientId },
            message: message,
        }
    }, function (error, response, body) {
        if (error) {
            console.log('Error sending message: ', error);
        } else if (response.body.error) {
            console.log('Error: ', response.body.error);
        }
    });
};

// send rich message with kitten
function carMessage(recipientId, text) {
    if (text.toLowerCase().indexOf('porsche') >= 0) {
        request('http://192.241.139.114:8050/products?where=name,Cruze', function (error, response, body) {
            if (!error && response.statusCode == 200) {
                console.log(body)
            }
        })
        var imageUrl = "http://lojawesellcars.pifferdigital.com.br/wp-content/uploads/2014/11/boxster151.jpg"
        message = {
            "attachment": {
                "type": "template",
                "payload": {
                    "template_type": "generic",
                    "elements": [{
                        "title": "Encontrei este Porsche Boxster especialmente para você!      R$354.000,00",
                        "subtitle": "Porsche Boxster Type-S Conversível",
                        "image_url": imageUrl,
                        "buttons": [{
                            "type": "web_url",
                            "url": "http://lojawesellcars.pifferdigital.com.br/listings/2014-porsche-boxster-type-s-convertible",
                            "title": "Comprar carro"
                        }, {
                            "type": "web_url",
                            "url": "https://www.facebook.com/photo.php?fbid=1329873560365296&set=a.658635760822416.1073741826.100000279936586&type=3&theater",
                            "title": "VR - Ver interior"
                        },
                        {
                            "type": "web_url",
                            "url": "https://youtu.be/fPdfPGjgt1w",
                            "title": "VR - Ver exterior"
                        }]
                    }]
                }
            }
        };
        sendMessage(recipientId, message);
        return true;
        }
    return false;
};
