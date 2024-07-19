module Evergreen.V2.IdleGame.Kinds exposing (..)


type Resource
    = AnatomyK
    | AnatomyPK
    | AnatomyFlashcard
    | BiochemistryK
    | BiochemistryPK
    | BiochemistryFlashcard
    | PhysiologyK
    | PhysiologyPK
    | PhysiologyFlashcard
    | PharmacologyK
    | PharmacologyPK
    | PharmacologyFlashcard
    | MicrobiologyK
    | MicrobiologyPK
    | MicrobiologyFlashcard
    | PathologyK
    | PathologyPK
    | PathologyFlashcard
    | MedicalEthicsK
    | MedicalEthicsPK
    | MedicalEthicsFlashcard


type Skill
    = Anatomy
    | Biochemistry
    | Physiology
    | Pharmacology
    | Microbiology
    | Pathology
    | MedicalEthics
    | Labs


type Activity
    = BackAndSpine
    | UpperLimb
    | LowerLimb
    | Thorax
    | Abdomen
    | PelvisAndPerineum
    | HeadAndNeck
    | IntegumentarySystem
    | LymphaticAndImmuneSystem
    | MetabolicPathways
    | Enzymology
    | MolecularBiology
    | LipidMetabolism
    | CarbohydrateMetabolism
    | ProteinSynthesis
    | NucleicAcidMetabolism
    | BiochemicalSignaling
    | VitaminsAndCoenzymes
    | CellularFunction
    | CardiovascularSystem
    | RespiratorySystem
    | RenalFunction
    | DigestiveSystem
    | NervousSystem
    | EndocrineSystem
    | ReproductiveSystem
    | ImmuneResponse
    | Pharmacokinetics
    | Pharmacodynamics
    | Toxicology
    | DrugMetabolism
    | PharmacologicalTherapeutics
    | ClinicalPharmacology
    | Neuropharmacology
    | Chemotherapy
    | CardiovascularPharmacology
    | Bacteriology
    | Virology
    | Mycology
    | Parasitology
    | Immunology
    | MicrobialGenetics
    | HostPathogenInteractions
    | ClinicalMicrobiology
    | AntimicrobialResistance
    | CellInjury
    | Inflammation
    | HemodynamicDisorders
    | Immunopathology
    | GeneticDisorders
    | Neoplasia
    | InfectiousDiseases
    | EnvironmentalPathology
    | NutritionalDisorders
    | PrinciplesOfBioethics
    | InformedConsent
    | ConfidentialityAndPrivacy
    | EndOfLifeDecisionMaking
    | MedicalProfessionalism
    | ResearchEthics
    | Lab1
    | Lab2
    | Lab3
    | Lab4
    | Lab5
    | Lab6


type alias ResourceRecord a =
    { anatomyK : a
    , anatomyPK : a
    , anatomyFlashcard : a
    , biochemistryK : a
    , biochemistryPK : a
    , biochemistryFlashcard : a
    , physiologyK : a
    , physiologyPK : a
    , physiologyFlashcard : a
    , pharmacologyK : a
    , pharmacologyPK : a
    , pharmacologyFlashcard : a
    , microbiologyK : a
    , microbiologyPK : a
    , microbiologyFlashcard : a
    , pathologyK : a
    , pathologyPK : a
    , pathologyFlashcard : a
    , medicalEthicsK : a
    , medicalEthicsPK : a
    , medicalEthicsFlashcard : a
    }


type alias SkillRecord a =
    { anatomy : a
    , biochemistry : a
    , physiology : a
    , pharmacology : a
    , microbiology : a
    , pathology : a
    , medicalEthics : a
    , labs : a
    }


type alias ActivityRecord a =
    { backAndSpine : a
    , upperLimb : a
    , lowerLimb : a
    , thorax : a
    , abdomen : a
    , pelvisAndPerineum : a
    , headAndNeck : a
    , integumentarySystem : a
    , lymphaticAndImmuneSystem : a
    , metabolicPathways : a
    , enzymology : a
    , molecularBiology : a
    , lipidMetabolism : a
    , carbohydrateMetabolism : a
    , proteinSynthesis : a
    , nucleicAcidMetabolism : a
    , biochemicalSignaling : a
    , vitaminsAndCoenzymes : a
    , cellularFunction : a
    , cardiovascularSystem : a
    , respiratorySystem : a
    , renalFunction : a
    , digestiveSystem : a
    , nervousSystem : a
    , endocrineSystem : a
    , reproductiveSystem : a
    , immuneResponse : a
    , pharmacokinetics : a
    , pharmacodynamics : a
    , toxicology : a
    , drugMetabolism : a
    , pharmacologicalTherapeutics : a
    , clinicalPharmacology : a
    , neuropharmacology : a
    , chemotherapy : a
    , cardiovascularPharmacology : a
    , bacteriology : a
    , virology : a
    , mycology : a
    , parasitology : a
    , immunology : a
    , microbialGenetics : a
    , hostPathogenInteractions : a
    , clinicalMicrobiology : a
    , antimicrobialResistance : a
    , cellInjury : a
    , inflammation : a
    , hemodynamicDisorders : a
    , immunopathology : a
    , geneticDisorders : a
    , neoplasia : a
    , infectiousDiseases : a
    , environmentalPathology : a
    , nutritionalDisorders : a
    , principlesOfBioethics : a
    , informedConsent : a
    , confidentialityAndPrivacy : a
    , endOfLifeDecisionMaking : a
    , medicalProfessionalism : a
    , researchEthics : a
    , lab1 : a
    , lab2 : a
    , lab3 : a
    , lab4 : a
    , lab5 : a
    , lab6 : a
    }


type alias ShopUpgradeRecord a =
    { glasses : a
    }


type alias AcademicTestRecord a =
    { anatomy1 : a
    , anatomy2 : a
    , anatomy3 : a
    , anatomy4 : a
    , anatomy5 : a
    , biochemistry1 : a
    , biochemistry2 : a
    , biochemistry3 : a
    , biochemistry4 : a
    , biochemistry5 : a
    , physiology1 : a
    , physiology2 : a
    , physiology3 : a
    , physiology4 : a
    , physiology5 : a
    , pharmacology1 : a
    , pharmacology2 : a
    , pharmacology3 : a
    , pharmacology4 : a
    , pharmacology5 : a
    , microbiology1 : a
    , microbiology2 : a
    , microbiology3 : a
    , microbiology4 : a
    , microbiology5 : a
    , pathology1 : a
    , pathology2 : a
    , pathology3 : a
    , pathology4 : a
    , pathology5 : a
    , medicalEthics1 : a
    , medicalEthics2 : a
    , medicalEthics3 : a
    , shelfExamAnatomy : a
    , shelfExamBiochemistry : a
    , shelfExamPhysiology : a
    , shelfExamPharmacology : a
    , shelfExamMicrobiology : a
    , shelfExamPathology : a
    , usmleStep1Test : a
    }


type AcademicTestCategory
    = Quiz
    | ShelfExam
    | UsmleStep1


type AcademicTest
    = Anatomy1
    | Anatomy2
    | Anatomy3
    | Anatomy4
    | Anatomy5
    | Biochemistry1
    | Biochemistry2
    | Biochemistry3
    | Biochemistry4
    | Biochemistry5
    | Physiology1
    | Physiology2
    | Physiology3
    | Physiology4
    | Physiology5
    | Pharmacology1
    | Pharmacology2
    | Pharmacology3
    | Pharmacology4
    | Pharmacology5
    | Microbiology1
    | Microbiology2
    | Microbiology3
    | Microbiology4
    | Microbiology5
    | Pathology1
    | Pathology2
    | Pathology3
    | Pathology4
    | Pathology5
    | MedicalEthics1
    | MedicalEthics2
    | MedicalEthics3
    | ShelfExamAnatomy
    | ShelfExamBiochemistry
    | ShelfExamPhysiology
    | ShelfExamPharmacology
    | ShelfExamMicrobiology
    | ShelfExamPathology
    | UsmleStep1Test


type ShopUpgrade
    = Glasses
