# A* app

This application is a student project realizing the functionality of:

- building a graph model by creating and deleting nodes and weighted relationships between them. 
- building graph model by reading a build description in a text file.  
- ✨Mininal path search with A* algorithm✨

![graph_model](https://github.com/Meowchine1/astarQml/blob/main/inputFiles/graphPicture.png)

![Main_window](https://github.com/Meowchine1/astarQml/blob/main/inputFiles/mainApp.png)

![Nodes_creating](https://github.com/Meowchine1/astarQml/blob/main/inputFiles/modelCreation.png)

![Relations_setting](https://github.com/Meowchine1/astarQml/blob/main/inputFiles/setRelations.png)

![Algorithm_work_result](https://github.com/Meowchine1/astarQml/blob/main/inputFiles/result.png)

## Reading file format

File row template: node_name(x,y) [{child_name(edje_weight), ...}] , where

file row count = graph node count

*You can find file example in input file directory of this project.*

## Building and installation
### Building and installing on ALT-Linux

On ALT-Linux distributions all build dependencies can be installed with following command:

```
apt-get install cmake gcc-c++ qt5-base-devel qt5-tools-devel qt5-quickcontrols qt5-quickcontrols2 qt5-quickcontrols2-devel
```
Building with CMake and Make
```
mkdir -p build
cmake -B build .
cd build && make -j `nproc`
```

## License

GPL 

**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [dill]: <https://github.com/joemccann/dillinger>
   [git-repo-url]: <https://github.com/joemccann/dillinger.git>
   [john gruber]: <http://daringfireball.net>
   [df1]: <http://daringfireball.net/projects/markdown/>
   [markdown-it]: <https://github.com/markdown-it/markdown-it>
   [Ace Editor]: <http://ace.ajax.org>
   [node.js]: <http://nodejs.org>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [jQuery]: <http://jquery.com>
   [@tjholowaychuk]: <http://twitter.com/tjholowaychuk>
   [express]: <http://expressjs.com>
   [AngularJS]: <http://angularjs.org>
   [Gulp]: <http://gulpjs.com>

   [PlDb]: <https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md>
   [PlGh]: <https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md>
   [PlGd]: <https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md>
   [PlOd]: <https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md>
   [PlMe]: <https://github.com/joemccann/dillinger/tree/master/plugins/medium/README.md>
   [PlGa]: <https://github.com/RahulHP/dillinger/blob/master/plugins/googleanalytics/README.md>

