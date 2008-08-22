#############################################################################
##
##  LIMOR.gi                    LIMOR subpackage             Mohamed Barakat
##
##         LIMOR = Logical Implications for homalg MODules
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the LIMOR subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIMOR,
        rec(
            color := "\033[4;30;46m" )
        );

##
InstallValue( LogicalImplicationsForHomalgMorphisms,
        [ 
          
          [ IsMorphism,
            "implies", IsGeneralizedMorphism ],
          
          [ IsMonomorphism,
            "implies", IsMorphism ],
          
          [ IsMonomorphism,
            "implies", IsGeneralizedMonomorphism ],
          
          [ IsGeneralizedMonomorphism,
            "implies", IsGeneralizedMorphism ],
          
          [ IsEpimorphism,
            "implies", IsMorphism ],
          
          [ IsEpimorphism,
            "implies", IsGeneralizedEpimorphism ],
          
          [ IsGeneralizedEpimorphism,
            "implies", IsGeneralizedMorphism ],
          
          [ IsAutomorphism,
            "implies", IsIsomorphism ],
          
          [ IsIsomorphism,
            "implies", IsGeneralizedIsomorphism ],
          
          [ IsIsomorphism,
            "implies", IsSplitMonomorphism ],
          
          [ IsIsomorphism,
            "implies", IsSplitEpimorphism ],
          
          [ IsSplitEpimorphism,
            "implies", IsEpimorphism ],
          
          [ IsSplitMonomorphism,
            "implies", IsMonomorphism ],
          
          [ IsEpimorphism, "and", IsMonomorphism,
            "imply", IsIsomorphism ],
          
          [ IsGeneralizedIsomorphism,
            "implies", IsGeneralizedMonomorphism ],
          
          [ IsGeneralizedIsomorphism,
            "implies", IsGeneralizedEpimorphism ],
          
          [ IsGeneralizedEpimorphism, "and", IsGeneralizedMonomorphism,
            "imply", IsGeneralizedIsomorphism ],
          
          [ IsIdentityMorphism,
            "implies", IsAutomorphism ],
          
          ] );

##
InstallValue( LogicalImplicationsForHomalgEndomorphisms,
        [ 
          
          [ IsIsomorphism,
            "implies", IsAutomorphism ],
          
          ] );

##
InstallValue( LogicalImplicationsForHomalgChainMaps,
        [ 
          
          [ IsGradedMorphism,
            "implies", IsMorphism ],
          
          [ IsIsomorphism,
            "implies", IsQuasiIsomorphism ],
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgMorphisms, IsHomalgMorphism );

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgEndomorphisms, IsHomalgEndomorphism );

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgChainMaps, IsHomalgChainMap );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsZero,
        IsHomalgMorphism, 0,
        
  function( phi )
    
    if ( HasIsZero( Source( phi ) ) and IsZero( Source( phi ) ) ) or
       ( HasIsZero( Range( phi ) ) and IsZero( Range( phi ) ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsMapOfFinitelyGeneratedModulesRep, 0,
        
  function( phi )
    
    if HasIsZero( MatrixOfMap( phi ) ) and IsZero( MatrixOfMap( phi ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsMapOfFinitelyGeneratedModulesRep, 0,
        
  function( phi )
    local index_pair, matrix;
    
    index_pair := PairOfPositionsOfTheDefaultSetOfRelations( phi );
    
    if IsBound( phi!.reduced_matrices.( String( index_pair ) ) ) then
        
        matrix := phi!.reduced_matrices.( String( index_pair ) );
        
        if HasIsZero( matrix ) then
            return IsZero( matrix );
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsSplitEpimorphism,
        IsMapOfFinitelyGeneratedModulesRep and IsEpimorphism, 0,
        
  function( phi )
    local T;
    
    T := Range( phi );
    
    if HasIsProjective( T ) and IsProjective( T ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsAutomorphism,
        IsHomalgMorphism, 0,
        
  function( phi )
    
    if not IsIdenticalObj( Source( phi ), Range( phi ) ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsGradedMorphism,
        IsHomalgChainMap, 0,
        
  function( phi )
    local S, T;
    
    S := Source( phi );
    T := Range( phi );
    
    if HasIsGradedObject( S ) and HasIsGradedObject( T ) then
        return IsGradedObject( S ) and IsGradedObject( T );
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZero,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsZero( DecideZero( phi ) );
    
end );

##
InstallMethod( IsMorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfRelations( Source( phi ) ) * MatrixOfMap( phi );
    
    return IsZero( DecideZero( mat , RelationsOfModule( Range( phi ) ) ) );
    
end );

##
InstallMethod( IsMorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfMap( phi ) * MatrixOfRelations( Source( phi ) );
    
    return IsZero( DecideZero( mat , RelationsOfModule( Range( phi ) ) ) );
    
end );

##
InstallMethod( IsGeneralizedMorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMorphism( phi );		## this is just the fall back method
    
end );

##
InstallMethod( IsGeneralizedMorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and HasMorphismAidMap ],
        
  function( phi )
    local mat, S, T;
    
    mat := MatrixOfMap( phi );
    
    S := Source( phi );
    
    T := Presentation( UnionOfRelations( MorphismAidMap( phi ) ) );
    
    return IsMorphism( HomalgMap( mat, S, T ) );
    
end );

##
InstallMethod( IsEpimorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMorphism( phi ) and IsZero( Cokernel( phi ) );
    
end );

##
InstallMethod( IsGeneralizedEpimorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsEpimorphism( phi );	## this is just the fall back method
    
end );

##
InstallMethod( IsGeneralizedEpimorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and HasMorphismAidMap ],
        
  function( phi )
    local mat, S, T, mu;
    
    mat := MatrixOfMap( phi );
    
    S := Source( phi );
    
    T := Presentation( UnionOfRelations( MorphismAidMap( phi ) ) );
    
    mu := HomalgMap( mat, S, T );
    
    SetIsGeneralizedMorphism( phi, IsMorphism( mu ) );
    
    return IsEpimorphism( mu );
    
end );

##
InstallMethod( IsMonomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMorphism( phi ) and IsZero( Kernel( phi ) );
    
end );

##
InstallMethod( IsGeneralizedMonomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMonomorphism( phi );	## this is just the fall back method
    
end );

##
InstallMethod( IsGeneralizedMonomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and HasMorphismAidMap ],
        
  function( phi )
    local mat, S, T, mu;
    
    mat := MatrixOfMap( phi );
    
    S := Source( phi );
    
    T := Presentation( UnionOfRelations( MorphismAidMap( phi ) ) );
    
    mu := HomalgMap( mat, S, T );
    
    SetIsGeneralizedMorphism( phi, IsMorphism( mu ) );
    
    return IsMonomorphism( mu );
    
end );

##
InstallMethod( IsIsomorphism,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return IsEpimorphism( phi ) and IsMonomorphism( phi );
    
end );

##
InstallMethod( IsGeneralizedIsomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsIsomorphism( phi );	## this is just the fall back method
    
end );

##
InstallMethod( IsGeneralizedIsomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and HasMorphismAidMap ],
        
  function( phi )
    local mat, S, T, mu;
    
    mat := MatrixOfMap( phi );
    
    S := Source( phi );
    
    T := Presentation( UnionOfRelations( MorphismAidMap( phi ) ) );
    
    mu := HomalgMap( mat, S, T );
    
    SetIsGeneralizedMorphism( phi, IsMorphism( mu ) );
    
    SetIsGeneralizedMonomorphism( phi, IsMonomorphism( mu ) );
    
    return IsIsomorphism( mu );
    
end );

##
InstallMethod( IsAutomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsHomalgSelfMap( phi ) and IsIsomorphism( phi );
    
end );

##
InstallMethod( IsGradedMorphism,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    return IsGradedObject( Source( phi ) ) and IsGradedObject( Range( phi ) );
    
end );

##
InstallMethod( IsQuasiIsomorphism,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    return IsIsomorphism( DefectOfExactness( phi ) );
    
end );

