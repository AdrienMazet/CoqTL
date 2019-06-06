(********************************************************************
	@name Coq declarations for model
	@date 2019/06/06 21:14:59
	@description Automatically generated by XMI2Coq transformation.
 ********************************************************************)
		 
Require Import List.
Require Import core.Model.
Require Import examples.TT2BDD.TT.


Definition InputModel : Model TTMetamodel_EObject TTMetamodel_ELink :=
	(Build_Model
		(
		(Build_TTMetamodel_EObject CellEClass (BuildCell (BuildLocatedElement "961419791_LocatedElement" "") "961419791_Cell" true)) :: 
		(Build_TTMetamodel_EObject CellEClass (BuildCell (BuildLocatedElement "394714818_LocatedElement" "") "394714818_Cell" true)) :: 
		(Build_TTMetamodel_EObject CellEClass (BuildCell (BuildLocatedElement "665188480_LocatedElement" "") "665188480_Cell" true)) :: 
		(Build_TTMetamodel_EObject InputPortEClass (BuildInputPort (BuildPort (BuildLocatedElement "1454031203_LocatedElement" "") "1454031203_Port" "a") "1454031203_InputPort" )) :: 
		(Build_TTMetamodel_EObject CellEClass (BuildCell (BuildLocatedElement "489279267_LocatedElement" "") "489279267_Cell" false)) :: 
		(Build_TTMetamodel_EObject RowEClass (BuildRow (BuildLocatedElement "366004251_LocatedElement" "") "366004251_Row" )) :: 
		(Build_TTMetamodel_EObject CellEClass (BuildCell (BuildLocatedElement "377478451_LocatedElement" "") "377478451_Cell" false)) :: 
		(Build_TTMetamodel_EObject TruthTableEClass (BuildTruthTable (BuildLocatedElement "407858146_LocatedElement" "") "407858146_TruthTable" "Test")) :: 
		(Build_TTMetamodel_EObject RowEClass (BuildRow (BuildLocatedElement "1408652377_LocatedElement" "") "1408652377_Row" )) :: 
		(Build_TTMetamodel_EObject CellEClass (BuildCell (BuildLocatedElement "513169028_LocatedElement" "") "513169028_Cell" false)) :: 
		(Build_TTMetamodel_EObject RowEClass (BuildRow (BuildLocatedElement "1596467899_LocatedElement" "") "1596467899_Row" )) :: 
		(Build_TTMetamodel_EObject InputPortEClass (BuildInputPort (BuildPort (BuildLocatedElement "527446182_LocatedElement" "") "527446182_Port" "b") "527446182_InputPort" )) :: 
		(Build_TTMetamodel_EObject RowEClass (BuildRow (BuildLocatedElement "963601816_LocatedElement" "") "963601816_Row" )) :: 
		(Build_TTMetamodel_EObject CellEClass (BuildCell (BuildLocatedElement "1301664418_LocatedElement" "") "1301664418_Cell" false)) :: 
		(Build_TTMetamodel_EObject CellEClass (BuildCell (BuildLocatedElement "1952779858_LocatedElement" "") "1952779858_Cell" true)) :: 
		(Build_TTMetamodel_EObject CellEClass (BuildCell (BuildLocatedElement "1791868405_LocatedElement" "") "1791868405_Cell" false)) :: 
		(Build_TTMetamodel_EObject CellEClass (BuildCell (BuildLocatedElement "391618063_LocatedElement" "") "391618063_Cell" true)) :: 
		(Build_TTMetamodel_EObject CellEClass (BuildCell (BuildLocatedElement "990416209_LocatedElement" "") "990416209_Cell" false)) :: 
		(Build_TTMetamodel_EObject CellEClass (BuildCell (BuildLocatedElement "1260134048_LocatedElement" "") "1260134048_Cell" true)) :: 
		(Build_TTMetamodel_EObject OutputPortEClass (BuildOutputPort (BuildPort (BuildLocatedElement "1511785794_LocatedElement" "") "1511785794_Port" "s") "1511785794_OutputPort" )) :: 
		nil)
		(
		(Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner (BuildCell (BuildLocatedElement "961419791_LocatedElement" "") "961419791_Cell" true) (BuildRow (BuildLocatedElement "963601816_LocatedElement" "") "963601816_Row" ))) ::
		(Build_TTMetamodel_ELink CellPortEReference (BuildCellPort (BuildCell (BuildLocatedElement "961419791_LocatedElement" "") "961419791_Cell" true) (BuildPort (BuildLocatedElement "1454031203_LocatedElement" "") "1454031203_Port" "a"))) ::
		(Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner (BuildCell (BuildLocatedElement "394714818_LocatedElement" "") "394714818_Cell" true) (BuildRow (BuildLocatedElement "1408652377_LocatedElement" "") "1408652377_Row" ))) ::
		(Build_TTMetamodel_ELink CellPortEReference (BuildCellPort (BuildCell (BuildLocatedElement "394714818_LocatedElement" "") "394714818_Cell" true) (BuildPort (BuildLocatedElement "527446182_LocatedElement" "") "527446182_Port" "b"))) ::
		(Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner (BuildCell (BuildLocatedElement "665188480_LocatedElement" "") "665188480_Cell" true) (BuildRow (BuildLocatedElement "963601816_LocatedElement" "") "963601816_Row" ))) ::
		(Build_TTMetamodel_ELink CellPortEReference (BuildCellPort (BuildCell (BuildLocatedElement "665188480_LocatedElement" "") "665188480_Cell" true) (BuildPort (BuildLocatedElement "527446182_LocatedElement" "") "527446182_Port" "b"))) ::
		(Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner (BuildCell (BuildLocatedElement "489279267_LocatedElement" "") "489279267_Cell" false) (BuildRow (BuildLocatedElement "963601816_LocatedElement" "") "963601816_Row" ))) ::
		(Build_TTMetamodel_ELink CellPortEReference (BuildCellPort (BuildCell (BuildLocatedElement "489279267_LocatedElement" "") "489279267_Cell" false) (BuildPort (BuildLocatedElement "1511785794_LocatedElement" "") "1511785794_Port" "s"))) ::
		(Build_TTMetamodel_ELink RowOwnerEReference (BuildRowOwner (BuildRow (BuildLocatedElement "366004251_LocatedElement" "") "366004251_Row" ) (BuildTruthTable (BuildLocatedElement "407858146_LocatedElement" "") "407858146_TruthTable" "Test"))) ::
		(Build_TTMetamodel_ELink RowCellsEReference (BuildRowCells (BuildRow (BuildLocatedElement "366004251_LocatedElement" "") "366004251_Row" ) ((BuildCell (BuildLocatedElement "1791868405_LocatedElement" "") "1791868405_Cell" false) :: (BuildCell (BuildLocatedElement "1260134048_LocatedElement" "") "1260134048_Cell" true) :: (BuildCell (BuildLocatedElement "391618063_LocatedElement" "") "391618063_Cell" true) :: nil ))) ::
		(Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner (BuildCell (BuildLocatedElement "377478451_LocatedElement" "") "377478451_Cell" false) (BuildRow (BuildLocatedElement "1596467899_LocatedElement" "") "1596467899_Row" ))) ::
		(Build_TTMetamodel_ELink CellPortEReference (BuildCellPort (BuildCell (BuildLocatedElement "377478451_LocatedElement" "") "377478451_Cell" false) (BuildPort (BuildLocatedElement "1454031203_LocatedElement" "") "1454031203_Port" "a"))) ::
		(Build_TTMetamodel_ELink TruthTablePortsEReference (BuildTruthTablePorts (BuildTruthTable (BuildLocatedElement "407858146_LocatedElement" "") "407858146_TruthTable" "Test") ((BuildPort (BuildLocatedElement "1454031203_LocatedElement" "") "1454031203_Port" "a") :: (BuildPort (BuildLocatedElement "527446182_LocatedElement" "") "527446182_Port" "b") :: (BuildPort (BuildLocatedElement "1511785794_LocatedElement" "") "1511785794_Port" "s") :: nil ))) ::
		(Build_TTMetamodel_ELink TruthTableRowsEReference (BuildTruthTableRows (BuildTruthTable (BuildLocatedElement "407858146_LocatedElement" "") "407858146_TruthTable" "Test") ((BuildRow (BuildLocatedElement "963601816_LocatedElement" "") "963601816_Row" ) :: (BuildRow (BuildLocatedElement "1596467899_LocatedElement" "") "1596467899_Row" ) :: (BuildRow (BuildLocatedElement "1408652377_LocatedElement" "") "1408652377_Row" ) :: (BuildRow (BuildLocatedElement "366004251_LocatedElement" "") "366004251_Row" ) :: nil ))) ::
		(Build_TTMetamodel_ELink RowOwnerEReference (BuildRowOwner (BuildRow (BuildLocatedElement "1408652377_LocatedElement" "") "1408652377_Row" ) (BuildTruthTable (BuildLocatedElement "407858146_LocatedElement" "") "407858146_TruthTable" "Test"))) ::
		(Build_TTMetamodel_ELink RowCellsEReference (BuildRowCells (BuildRow (BuildLocatedElement "1408652377_LocatedElement" "") "1408652377_Row" ) ((BuildCell (BuildLocatedElement "990416209_LocatedElement" "") "990416209_Cell" false) :: (BuildCell (BuildLocatedElement "394714818_LocatedElement" "") "394714818_Cell" true) :: (BuildCell (BuildLocatedElement "1952779858_LocatedElement" "") "1952779858_Cell" true) :: nil ))) ::
		(Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner (BuildCell (BuildLocatedElement "513169028_LocatedElement" "") "513169028_Cell" false) (BuildRow (BuildLocatedElement "1596467899_LocatedElement" "") "1596467899_Row" ))) ::
		(Build_TTMetamodel_ELink CellPortEReference (BuildCellPort (BuildCell (BuildLocatedElement "513169028_LocatedElement" "") "513169028_Cell" false) (BuildPort (BuildLocatedElement "527446182_LocatedElement" "") "527446182_Port" "b"))) ::
		(Build_TTMetamodel_ELink RowOwnerEReference (BuildRowOwner (BuildRow (BuildLocatedElement "1596467899_LocatedElement" "") "1596467899_Row" ) (BuildTruthTable (BuildLocatedElement "407858146_LocatedElement" "") "407858146_TruthTable" "Test"))) ::
		(Build_TTMetamodel_ELink RowCellsEReference (BuildRowCells (BuildRow (BuildLocatedElement "1596467899_LocatedElement" "") "1596467899_Row" ) ((BuildCell (BuildLocatedElement "377478451_LocatedElement" "") "377478451_Cell" false) :: (BuildCell (BuildLocatedElement "513169028_LocatedElement" "") "513169028_Cell" false) :: (BuildCell (BuildLocatedElement "1301664418_LocatedElement" "") "1301664418_Cell" false) :: nil ))) ::
		(Build_TTMetamodel_ELink RowOwnerEReference (BuildRowOwner (BuildRow (BuildLocatedElement "963601816_LocatedElement" "") "963601816_Row" ) (BuildTruthTable (BuildLocatedElement "407858146_LocatedElement" "") "407858146_TruthTable" "Test"))) ::
		(Build_TTMetamodel_ELink RowCellsEReference (BuildRowCells (BuildRow (BuildLocatedElement "963601816_LocatedElement" "") "963601816_Row" ) ((BuildCell (BuildLocatedElement "961419791_LocatedElement" "") "961419791_Cell" true) :: (BuildCell (BuildLocatedElement "665188480_LocatedElement" "") "665188480_Cell" true) :: (BuildCell (BuildLocatedElement "489279267_LocatedElement" "") "489279267_Cell" false) :: nil ))) ::
		(Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner (BuildCell (BuildLocatedElement "1301664418_LocatedElement" "") "1301664418_Cell" false) (BuildRow (BuildLocatedElement "1596467899_LocatedElement" "") "1596467899_Row" ))) ::
		(Build_TTMetamodel_ELink CellPortEReference (BuildCellPort (BuildCell (BuildLocatedElement "1301664418_LocatedElement" "") "1301664418_Cell" false) (BuildPort (BuildLocatedElement "1511785794_LocatedElement" "") "1511785794_Port" "s"))) ::
		(Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner (BuildCell (BuildLocatedElement "1952779858_LocatedElement" "") "1952779858_Cell" true) (BuildRow (BuildLocatedElement "1408652377_LocatedElement" "") "1408652377_Row" ))) ::
		(Build_TTMetamodel_ELink CellPortEReference (BuildCellPort (BuildCell (BuildLocatedElement "1952779858_LocatedElement" "") "1952779858_Cell" true) (BuildPort (BuildLocatedElement "1511785794_LocatedElement" "") "1511785794_Port" "s"))) ::
		(Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner (BuildCell (BuildLocatedElement "1791868405_LocatedElement" "") "1791868405_Cell" false) (BuildRow (BuildLocatedElement "366004251_LocatedElement" "") "366004251_Row" ))) ::
		(Build_TTMetamodel_ELink CellPortEReference (BuildCellPort (BuildCell (BuildLocatedElement "1791868405_LocatedElement" "") "1791868405_Cell" false) (BuildPort (BuildLocatedElement "1454031203_LocatedElement" "") "1454031203_Port" "a"))) ::
		(Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner (BuildCell (BuildLocatedElement "391618063_LocatedElement" "") "391618063_Cell" true) (BuildRow (BuildLocatedElement "366004251_LocatedElement" "") "366004251_Row" ))) ::
		(Build_TTMetamodel_ELink CellPortEReference (BuildCellPort (BuildCell (BuildLocatedElement "391618063_LocatedElement" "") "391618063_Cell" true) (BuildPort (BuildLocatedElement "1511785794_LocatedElement" "") "1511785794_Port" "s"))) ::
		(Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner (BuildCell (BuildLocatedElement "990416209_LocatedElement" "") "990416209_Cell" false) (BuildRow (BuildLocatedElement "1408652377_LocatedElement" "") "1408652377_Row" ))) ::
		(Build_TTMetamodel_ELink CellPortEReference (BuildCellPort (BuildCell (BuildLocatedElement "990416209_LocatedElement" "") "990416209_Cell" false) (BuildPort (BuildLocatedElement "1454031203_LocatedElement" "") "1454031203_Port" "a"))) ::
		(Build_TTMetamodel_ELink CellOwnerEReference (BuildCellOwner (BuildCell (BuildLocatedElement "1260134048_LocatedElement" "") "1260134048_Cell" true) (BuildRow (BuildLocatedElement "366004251_LocatedElement" "") "366004251_Row" ))) ::
		(Build_TTMetamodel_ELink CellPortEReference (BuildCellPort (BuildCell (BuildLocatedElement "1260134048_LocatedElement" "") "1260134048_Cell" true) (BuildPort (BuildLocatedElement "527446182_LocatedElement" "") "527446182_Port" "b"))) ::
				nil)
	).
