


 set (HEADERS
    tablemodel.h
	listmodel.h  
)

set (SOURCES
	main.cpp
    tablemodel.cpp 
	listmodel.cpp 
	 
) 

ADD_LIBRARY(adtcore STATIC ${SOURCES} ${HEADERS})

target_link_libraries(AstarApp
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick)
