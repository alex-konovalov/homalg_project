#############################################################################
##
##  AffineToricVariety.gd     ToricVarieties package       Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of affine toric Varieties
##
#############################################################################

DeclareCategory( "IsAffineToricVariety",
                 IsToricVariety );

#############################
##
## Properties
##
#############################


#############################
##
## Attributes
##
#############################

DeclareAttribute( "CoordinateRing",
                  IsAffineToricVariety );

DeclareAttribute( "ClosedEmbedding",
                  IsAffineToricVariety );

#############################
##
## Methods
##
#############################

DeclareOperation( "CoordinateRing",
                  [ IsAffineToricVariety, IsList ] );

DeclareOperation( "FanToConeRep",
                  [ IsToricVariety ] );

DeclareOperation( "ConeToFanRep",
                  [ IsToricVariety ] );


#############################
##
## Constructors
##
#############################
