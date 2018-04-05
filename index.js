const fs = require('fs');

const execSync = require('child_process').execSync;

var async = require('async');
var concat = require('concat-files')

var express = require('express');

var app = express();

app.use('/node_modules', express.static(__dirname + '/node_modules'));
app.use('/style',  express.static(__dirname + '/style'));
app.use('/public', express.static(__dirname + '/public'));
app.use('/images', express.static(__dirname + '/images'));

app.set('view engine', 'pug');

var router = express.Router();

router.use(function (req,res,next) {
  //console.log("/" + req.method);
  next();
});

router.get("/",function(req,res){
    res.render('index',{title: 'WorkoutPro', message: 'Welcome'})
});

router.get("/out",function(req,res){
    var age = req.query.age;
    var height = req.query.height;
    var weight = req.query.weight;
    var gen = req.query.gen;
    var injury = [] 
    if(req.query.injury!== undefined){
      injury =   req.query.injury
    }
    var exp = req.query.exp;
    var inst = [] = req.query.inst;
    var rut = req.query.rut;
    console.log(age);
    console.log(height);
    console.log(weight);
    console.log(gen);
    console.log(injury);
    console.log(exp);
    console.log(inst);
    console.log(rut);
    //process injury
    var string ='';
    async.waterfall([
       function(callback){
         if(injury !== undefined){
          for(var i = 0; i<injury.length; i++){
            string += '_input_injured(' +injury[i] + ').\n';
          }
         }

          string += '\n_expertise(' + exp + ').\n';
          
          for(var i = 0; i<inst.length; i++){
            string += '_is_available(' +inst[i] + ').\n';
          }
          callback(null, string)
       },
       function(string, callback){
          fs.writeFileSync("input.lp", string + '\n', function(err){
            if(err){
              return console.log(err);
            }
          });

          fs.writeFileSync("compute.lp", '\n#compute 1{_plan_workout('+age+','+height+','+weight
            +','+exp+','+rut+')}.', function(err){
            if(err){
              return console.log(err);
            }
          });
          callback(null);
       },
       function(callback){
          fs.readFile('input.lp', 'utf8', function(err, data){
            if(err) console.log(err);
            callback(null, data);
          });
       },
       function(data, callback){
          fs.readFile('WorkoutPro_sasp.lp', 'utf8', function(err, data1){
            if(err) console.log(err);
            callback(null, data + '\n' + data1);
          });
      },
      function(data2, callback){
          fs.readFile('compute.lp', 'utf8', function(err, data3){
            if(err) console.log(err);
            callback(null, data2 + '\n' + data3);
          });
      },
      function(data4, callback){
          fs.writeFileSync("workout_pro.lp", data4, function(err){
            if(err){
              return console.log(err);
            }
          });
          callback(null);
       },
      function(callback){
        execSync('./sasp workout_pro.lp > output', (error, stdout, stderr) => {
          if (error) {
            console.error(`exec error: ${error}`);
            return;
          }
          console.log(`stdout: ${stdout}`);
          console.log(`stderr: ${stderr}`);
          console.log('hhhe');
        });
        callback(null);
      },
      function(callback){
          fs.readFile('output', 'utf8', function(err, data){
            if(err) console.log(err);
            console.log(data);
            data = data.replace('{','');
            data = data.replace('}','');
            var dd = data.split('|');
            res.render('out',{result: data.trim(),res1: dd});
            callback(null);
          });
      }
    ],function(err){
      if(err){
        return console.log(err);
      }
    });
});


router.post("/",function(req,res){

});

app.use("/",router);

app.use("*",function(req,res){
  //res.sendFile(path + "404.html");
});

app.listen(3000,function(){
    console.log('live at 3000');
});