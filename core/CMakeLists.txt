 set (HEADERS
    NodeException.h
	splitter.h 
	astar.h 
	node.h 
	graph.h 
	heuristic.h

)

set (SOURCES
	appcore.cpp
    node.cpp 
	graph.cpp 
	astar.cpp
	 
) 

ADD_LIBRARY(adtcore STATIC ${SOURCES} ${HEADERS})

target_link_libraries(AstarCore
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick)
