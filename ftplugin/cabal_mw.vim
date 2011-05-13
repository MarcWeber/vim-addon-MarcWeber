syn match Error  'include-direct'
syn match Error  '.hs$'
setlocal sw=2

" templates
"    " adds commands and mappings for template usage
command! -nargs=0 InstertModules call vl#dev#haskell#cabal#InstertModules()

"Name
"Version
"License
"Author
"Homepage
"Category
"Build
"Synopsis
"Exposed
"Extensions
"and
"Name
"Version
"License
"Author
"Synopsis
"Build
"Executable
"Main
"Hs
"Executable
"Main
"Hs
"Other
"Name
"Version
"License
"Author
"Synopsis
"Build
"Exposed
"Executable
"Main
"Hs
"Other
"Executable
"Main
"Hs
"Other
"Extensions
"
"
"
"
    "[(OverlappingInstances
    ",(TypeSynonymInstances
    ",(TemplateHaskell
    ",(ForeignFunctionInterface
    ",(NoMonomorphismRestriction
    ",(NoMonoPatBinds
    ",(UndecidableInstances
    ",(IncoherentInstances
    ",(Arrows
    ",(Generics
    ",(NoImplicitPrelude
    ",(ImplicitParams
    ",(CPP
    ",(BangPatterns
    ",(KindSignatures
    ",(RecursiveDo
    ",(ParallelListComp
    ",(MultiParamTypeClasses
    ",(FunctionalDependencies
    ",(Rank2Types
    ",(RankNTypes
    ",(PolymorphicComponents
    ",(ExistentialQuantification
    ",(ScopedTypeVariables
    ",(FlexibleContexts
    ",(FlexibleInstances
    ",(EmptyDataDecls
    ",(PatternGuards
    ",(GeneralizedNewtypeDeriving
    ",(MagicHash
    ",(UnicodeSyntax
    ",(PatternSignatures
    ",(UnliftedFFITypes
    ",(LiberalTypeSynonyms
    ",(TypeOperators
    ",(GADTs
    ",(RelaxedPolyRec
    ",(ExtendedDefaultRules
    ",(UnboxedTuples
    ",(DeriveDataTypeable
    ",(ConstrainedClassMethods
    "
    "

"    -XOverlappingInstances
"    -XTypeSynonymInstances
"    -XTemplateHaskell
"    -XForeignFunctionInterface
"    -XNoMonomorphismRestriction
"    -XNoMonoPatBinds
"    -XUndecidableInstances
"    -XIncoherentInstances
"    -XArrows
"    -XGenerics
"    -XNoImplicitPrelude
"    -XImplicitParams
"    -XCPP
"    -XBangPatterns
"    -XKindSignatures
"    -XRecursiveDo
"    -XParallelListComp
"    -XMultiParamTypeClasses
"    -XFunctionalDependencies
"    -XRank2Types
"    -XRankNTypes
"    -XPolymorphicComponents
"    -XExistentialQuantification
"    -XScopedTypeVariables
"    -XFlexibleContexts
"    -XFlexibleInstances
"    -XEmptyDataDecls
"    -XPatternGuards
"    -XGeneralizedNewtypeDeriving
"    -XMagicHash
"    -XUnicodeSyntax
"    -XPatternSignatures
"    -XUnliftedFFITypes
"    -XLiberalTypeSynonyms
"    -XTypeOperators
"    -XGADTs
"    -XRelaxedPolyRec
"    -XExtendedDefaultRules
"    -XUnboxedTuples
"    -XDeriveDataTypeable
"    -XConstrainedClassMethods
