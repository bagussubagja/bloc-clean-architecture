A Clean Architecture Project with BLoC State Management

Structure Project :

.
├── core/
│ ├── constant
│ ├── error
│ ├── extension
│ ├── network
│ ├── router
│ ├── services
│ ├── theme
│ ├── usecases
│ └── util
├── data/
│ ├── data_source/
│ │ ├── local
│ │ └── remote
│ ├── models
│ └── repositories
├── domain/
│ ├── entities
│ ├── repositories
│ └── usecases
├── presentation/
│ ├── blocs
│ ├── views
│ └── widgets
└── main.dart