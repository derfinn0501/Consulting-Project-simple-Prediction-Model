library(readxl)
library(dplyr)
library(tidyr)
library(writexl)

# Assumed folder structure:
# 'data cleaning'
#     - data_cleaning.R
# data
#     - full_data.xlsx

full_data <- readxl::read_excel("../data/full_data.xlsx")
clean_data <- full_data

# Rename every column
clean_data <- clean_data %>% rename(
  "patient_id" = "Proband",
  "Y_HLOS" = "HLOS",
  "Y_ICU_LOS" = "ICU_LOS",
  "Y_IMC_LOS" = "IMC_LOS",
  "Y_ventilation_length" = "Ventilation",
  "Y_earnings" = "Erloes",
  "P_SSRF" = "SSRF", 
  "P_SSRF_OPS" = "SSRF_OPS",
  "Y_all_ICDs" = "alle_ICDs",
  "Y_ICD_S22_41" = "S22.41",
  "Y_ICD_S22_42" = "S22.42",
  "Y_ICD_S22_43" = "S22.43",
  "Y_ICD_S22_44" = "S22.44",
  "Y_ICD_S22_5" = "S22.5",
  "Y_ICD_S27_0" = "S27.0",
  "Y_ICD_S27_1" = "S27.1",
  "Y_ICD_S27_2" = "S27.2",
  "X_gender"= "Geschlecht",
  "Y_glasgow_outcome_scale" = "Glasgow.Outcome.Scale",
  "Y_pneumonia" = "Pneumonie.während.stationärem.Aufenthalt.",
  "Y_reintubation" = "Re.Intubation.nach.vorheriger.Extubation.",
  "Y_sepsis" = "Sepsis.während.stationärem.Aufenthalt.",
  "Y_organ_failure" = "Organversagen.der.Lunge.während.stationärem.Aufenthalt.",
  "Y_rezidiv_PTX" = "Rezidiv.Pneumothorax.nach.Entfernung.der.Thoraxdrainage.",
  "P_chest_tube" = "Wurde.eine.Thoraxdrainage.angelegt.",
  "P_chest_tube_side" = "Auf.welcher.Seite.wurde.die.Thoraxdrainage.angelegt.",
  "P_chest_tube_indication_right" = "Was.war.die.Indikation.zur.Anlage.der.Thoraxdrainage.rechts.",
  "P_chest_tube_indication_left" = "Was.war.die.Indikation.zur.Anlage.der.Thoraxdrainage.links.",
  "P_ribosteosynthesis" = "Erfolgte.eine.Rippenosteosynthese.",
  "P_ribosteosynthesis_indication" = "Was.war.die.Indikation.zur.Rippenosteosynthese",
  "P_ribosteosynthesis_side" = "Auf.welcher.Seite.erfolgte.die.Rippenosteosynthese.",
  "P_ribosteosynthesis_ribs_left" = "An.welchen.Rippen.links.erfolgte.die.Rippenosteosynthese.",
  "P_ribosteosynthesis_ribs_right" = "An.welchen.Rippen.rechts.erfolgte.die.Rippenosteosynthese.",
  "P_days_between_trauma_tube_right" = "days_between_trauma_tube_right",
  "P_days_between_trauma_tube_left" = "days_between_trauma_tube_left",
  "P_days_between_tube_insertion_removal_right" = "days_between_tube_insertion_removal_right",
  "P_days_between_tube_insertion_removal_left" = "days_between_tube_insertion_removal_left",
  "X_max_AIS_head" = "Maximaler.AIS.Kopf",
  "X_max_AIS_face" = "Maximaler.AIS.Gesicht",
  "X_max_AIS_throat" = "Maximaler.AIS.Hals",
  "X_max_AIS_thorax" = "Maximaler.AIS.Thorax",
  "X_max_AIS_abdomen" = "Maximaler.AIS.Abdomen",
  "X_max_AIS_pelvis" = "Maximaler.AIS.Becken",
  "X_max_AIS_spine" = "Maximaler.AIS.Wirbelsäule",
  "X_max_AIS_upper_limb" = "Maximaler.AIS.Obere.Extremitäten",
  "X_max_AIS_lower_limb" = "Maximaler.AIS.Untere.Extremitäten",
  "X_max_AIS_soft_tissue" = "Maximaler.AIS.Weichteile",
  "X_ISS" = "ISS",
  "X_broken_ribs_6plus" = "X..6.Rippen.gebrochen..jede.Rippe.zählt.nur.ein.mal.auch.bei.mehreren.Brüchen.einer.Rippe..",
  "X_bilaterial_rib_fractures" = "Bilaterale.Frakturen..mindestens.eine.Frakturierte.Rippe.links.und.rechts..",
  "X_flail_chest" = "Flail.Chest..3.oder.mehr.Rippen.in.Folge.mit.jeweils.2.oder.mehr.Frakturen..",
  "X_dislogged_ribs_3plus" = "X..3.stark.dislozierte..bikortikal..Frakturen.",
  "X_fracture_first_rib" = "Fraktur.der.ersten.Rippe.",
  "X_rib_fracture_every_region" = "Mindestens.eine.Fraktur.in.jeder.anatomischen.Region..ventral..lateral..dorsal..",
  "X_Horowitz_quotient" = "Horovitz.Quotient.PaO2.FiO2",
  "X_num_broken_ribs" = "Anzahl.Frakturierter.Rippen",
  "X_lungcontusion" = "Lungenkontusion",
  "X_pleural_involvement" = "Pleurabeteiligung",
  "X_PTX_side" = "Auf.welcher.Seite.ist.der.Pneumothorax.",
  "X_PTX_size_right" = "Wie.groß.ist.der.Pneumothorax.rechts.",
  "X_PTX_size_left" = "Wie.groß.ist.der.Pneumothorax.links.",
  "X_soft_tissue_emphysema" = "Gibt.es.ein.Weichteilemphysem.",
  "X_HTX_side" = "Auf.welcher.Seite.ist.der.Hämatothorax.",
  "X_HTX_size_right" = "Wie.groß.ist.der.Hämatothorax.rechts.",
  "X_HTX_size_left" = "Wie.groß.ist.der.Hämatothorax.links.",
  "X_RibScore" = "RibScore",
  "X_ASA" = "ASA",
  "X_antikoagulation_antiplatelet" = "Antikoagulation.Thrombozytenaggregationshemmer.in.Hausmedikation",
  "X_known_preconditions" = "Sind.Vorerkrankungen.bekannt.",
  "X_heart_insufficiency" = "Herzinsuffizienz.",
  "X_cardiac_dysrhythmia" = "Herzrhythmusstörung..z.B..Vorhofflimmern.",
  "X_heart_valve_disease" = "Herzklappenerkrankung.",
  "X_pulmonary_circulation_disease" = "Erkrankungen.des.Lungenkreislaufs..z.B..pulmonalarterielle.Hypertonie.",
  "X_vascular_disease" = "Periphere.Gefäßerkrankungen..z.B..pAVK.",
  "X_arterial_hypertension" = "Arterielle.Hypertonie",
  "X_plegia" = "Paresen.Plegien.",
  "X_neurodegenerative_disease" = "Neurodegenerative.Erkrankungen.",
  "X_chronic_lung_disease" = "Chronische.Lungenerkrankung.z.B..COPD.",
  "X_diabetes" = "Diabetes",
  "X_Hypothyroidism" = "Hypothyreose.",
  "X_Renal_insufficiency" = "Niereninsuffizienz.",
  "X_liver_disease" = "Leber.Erkrankung..z.B..Leberzirrhose.",
  "X_AIDS_HIV" = "AIDS.HIV.",
  "X_lymphoma" = "Lymphom.",
  "X_metastatic_tumor" = "Metastasierte.Tumorerkrankung.",
  "X_non_metastatic_tumor" = "Solider.Tumor.ohne.Metastasierung.",
  "X_Rheumatoid_arthritis_collagen_vascular_disease" = "Rheumatoide.Arthritis.oder.kollagenöse.Gefäßerkrankung.",
  "X_coagulopathy" = "Koagulopathie.",
  "X_obesity" = "Adipositas.",
  "X_unintential_weight_loss" = "Ungewollter.Gewichtsverlust.",
  "X_fluid_electrolyte_disorder" = "Flüssigkeits..oder.Elektrolytstörung.",
  "X_hemorrhagic_anemia" = "Blutungs.Anämie.",
  "X_drug_abuse" = "Drogenabusus.",
  "X_psychosis" = "Psychose.",
  "X_depression" = "Depression.",
  "X_Elixhauser" = "Elixhauser",
  "X_TTSS" = "TTS",
  "X_age_grouped" = "age_bin_midpoint"
  )


# Clean missing values and placeholders
clean_data <- clean_data %>% mutate(P_SSRF = recode_factor(P_SSRF, `0` = "No", `1` = "Yes"))
clean_data <- clean_data %>% mutate(Y_ICD_S22_41 = recode_factor(Y_ICD_S22_41, `0` = "No", `1` = "Yes"))
clean_data <- clean_data %>% mutate(Y_ICD_S22_42 = recode_factor(Y_ICD_S22_42, `0` = "No", `1` = "Yes"))
clean_data <- clean_data %>% mutate(Y_ICD_S22_43 = recode_factor(Y_ICD_S22_43, `0` = "No", `1` = "Yes"))
clean_data <- clean_data %>% mutate(Y_ICD_S22_44 = recode_factor(Y_ICD_S22_44, `0` = "No", `1` = "Yes"))
clean_data <- clean_data %>% mutate(Y_ICD_S22_5 = recode_factor(Y_ICD_S22_5, `0` = "No", `1` = "Yes"))
clean_data <- clean_data %>% mutate(Y_ICD_S27_0 = recode_factor(Y_ICD_S27_0, `0` = "No", `1` = "Yes"))
clean_data <- clean_data %>% mutate(Y_ICD_S27_1 = recode_factor(Y_ICD_S27_1, `0` = "No", `1` = "Yes"))
clean_data <- clean_data %>% mutate(Y_ICD_S27_2 = recode_factor(Y_ICD_S27_2, `0` = "No", `1` = "Yes"))
clean_data <- clean_data %>% mutate(Y_ICD_S22_5 = replace_na(Y_ICD_S22_5, "No"))
clean_data$X_gender <- as.factor(clean_data$X_gender)
clean_data <- clean_data %>% mutate(Y_glasgow_outcome_scale = recode_factor(Y_glasgow_outcome_scale,
                                                                            "Leichte bis keine Behinderung" = "light_or_none",
                                                                            "Mäßige Behinderung" = "medium",
                                                                            "Schwere Behinderung" = "high",
                                                                            "Tod" = "death",
                                                                            "Nicht verfügbar" = "not_available"))

clean_data <- clean_data %>% mutate(Y_pneumonia = recode_factor(Y_pneumonia,
                                                                "Nein" = "no",
                                                                "Ja" = "yes",
                                                                "Nicht zutreffend" = "not_applicable",
                                                                "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(Y_reintubation = recode_factor(Y_reintubation,
                                                                "Nein" = "no",
                                                                "Ja" = "yes",
                                                                "Nicht zutreffend" = "not_applicable",
                                                                "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(Y_sepsis = recode_factor(Y_sepsis,
                                                                   "Nein" = "no",
                                                                   "Ja" = "yes",
                                                                   "Nicht zutreffend" = "not_applicable",
                                                                   "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(Y_organ_failure = recode_factor(Y_organ_failure,
                                                             "Nein" = "no",
                                                             "Ja" = "yes",
                                                             "Nicht zutreffend" = "not_applicable",
                                                             "Nicht verfügbar" = "not_available"))


clean_data <- clean_data %>% mutate(Y_sepsis = replace_na(Y_sepsis, "no"))
clean_data <- clean_data %>% mutate(Y_organ_failure = replace_na(Y_organ_failure, "no"))
clean_data <- clean_data %>% mutate(P_chest_tube = recode_factor(P_chest_tube,
                                                                  "Nein" = "no",
                                                                  "Ja" = "yes",
                                                                  "Nicht zutreffend" = "not_applicable",
                                                                  "Nicht verfügbar" = "not_available"))


clean_data$Y_rezidiv_PTX <- ifelse(clean_data$P_chest_tube == "no", "not_applicable", clean_data$Y_rezidiv_PTX)
clean_data <- clean_data %>% mutate(Y_rezidiv_PTX = replace_na(Y_rezidiv_PTX, "not_available"))
clean_data <- clean_data %>% mutate(Y_rezidiv_PTX = recode_factor(Y_rezidiv_PTX,
                                                                  "Nein" = "no",
                                                                  "Ja" = "yes",
                                                                  "Nicht zutreffend" = "not_applicable",
                                                                  "Nicht verfügbar" = "not_available"))

clean_data$P_chest_tube_side <- ifelse(is.na(clean_data$P_chest_tube_side) & clean_data$P_chest_tube == "no", "not_applicable", clean_data$P_chest_tube_side)
clean_data <- clean_data %>% mutate(P_chest_tube_side = replace_na(P_chest_tube_side, "not_available"))
clean_data <- clean_data %>% mutate(P_chest_tube_side = recode_factor(P_chest_tube_side,
                                                                 "links" = "left",
                                                                 "rechts" = "right",
                                                                 "beidseits" = "both",
                                                                "not_applicable" = "not_applicable",
                                                                "not_available" = "not_available"
                                                                 ))

clean_data$P_chest_tube_indication_left <- ifelse(is.na(clean_data$P_chest_tube_indication_left) & clean_data$P_chest_tube == "no", "not_applicable", clean_data$P_chest_tube_indication_left)
clean_data <- clean_data %>% mutate(P_chest_tube_indication_left = replace_na(P_chest_tube_indication_left, "not_available"))
clean_data <- clean_data %>% mutate(P_chest_tube_indication_left = recode_factor(P_chest_tube_indication_left,
                                                                     "auf Grund einer Operation nicht an Rippen oder Lunge" = "operation_non_lung_rib",
                                                                     "primäre Indikation" = "primary_indication",
                                                                     "sekundäre Indikation bei Progress" = "secondary_indication_progress",
                                                                     "sekundäre Indikation ohne Progress" = "secondary_indication_no_progress",
                                                                     "im Rahmen einer Operation an Rippen oder Lunge" = "operation_lung_rib"
                                                                     ))
clean_data$P_chest_tube_indication_right <- ifelse(is.na(clean_data$P_chest_tube_indication_right) & clean_data$P_chest_tube == "no", "not_applicable", clean_data$P_chest_tube_indication_right)
clean_data <- clean_data %>% mutate(P_chest_tube_indication_right = replace_na(P_chest_tube_indication_right, "not_available"))
clean_data <- clean_data %>% mutate(P_chest_tube_indication_right = recode_factor(P_chest_tube_indication_right,
                                                                                 "auf Grund einer Operation nicht an Rippen oder Lunge" = "operation_non_lung_rib",
                                                                                 "primäre Indikation" = "primary_indication",
                                                                                 "sekundäre Indikation bei Progress" = "secondary_indication_progress",
                                                                                 "sekundäre Indikation ohne Progress" = "secondary_indication_no_progress",
                                                                                 "im Rahmen einer Operation an Rippen oder Lunge" = "operation_lung_rib",
                                                                                 "Nicht verfügbar" = "not_available"
                                                                                 ))

clean_data <- clean_data %>% mutate(P_ribosteosynthesis = recode_factor(P_ribosteosynthesis,
                                                                        "Nein" = "no",
                                                                        "Ja" = "yes",
                                                                        "Nicht zutreffend" = "not_applicable",
                                                                        "Nicht verfügbar" = "not_available"))

clean_data$P_ribosteosynthesis_indication <- ifelse(is.na(clean_data$P_ribosteosynthesis_indication) & clean_data$P_ribosteosynthesis == "no", "not_applicable", clean_data$P_ribosteosynthesis_indication)
clean_data <- clean_data %>% mutate(P_ribosteosynthesis_indication = replace_na(P_ribosteosynthesis_indication, "not_available"))
clean_data <- clean_data %>% mutate(P_ribosteosynthesis_indication = recode_factor(P_ribosteosynthesis_indication,
                                                                        "primäre Indikation" = "primary_indication",
                                                                        "sekundäre Indikation bei respiratorischem Versagen" = "secondary_respiratory_failure",
                                                                        "sekundäre Indikation bei Schmerzen" = "secondary_pain"
                                                                        ))

clean_data$P_ribosteosynthesis_side <- ifelse(clean_data$P_ribosteosynthesis == "no", "not_applicable", clean_data$P_ribosteosynthesis_side)
clean_data <- clean_data %>% mutate(P_ribosteosynthesis_side = replace_na(P_ribosteosynthesis_side, "not_available"))
clean_data <- clean_data %>% mutate(P_ribosteosynthesis_side = recode_factor(P_ribosteosynthesis_side,
                                                                             "links" = "left",
                                                                             "rechts" = "right",
                                                                             "beidseits" = "both")) 

clean_data <- clean_data %>% mutate(X_max_AIS_head = recode_factor(X_max_AIS_head,
                                                                   "keiner" = "none",
                                                                   "1" = "1",
                                                                   "2" = "2", 
                                                                   "3" = "3",
                                                                   "4" = "4",
                                                                   "5" = "5",
                                                                   "6" = "6",
                                                                   "Nicht verfügbar" = "not_available")) 

clean_data <- clean_data %>% mutate(X_max_AIS_face = recode_factor(X_max_AIS_face,
                                                                   "keiner" = "none",
                                                                   "1" = "1",
                                                                   "2" = "2", 
                                                                   "3" = "3",
                                                                   "4" = "4",
                                                                   "5" = "5",
                                                                   "6" = "6",
                                                                   "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(X_max_AIS_throat = recode_factor(X_max_AIS_throat,
                                                                   "keiner" = "none",
                                                                   "1" = "1",
                                                                   "2" = "2", 
                                                                   "3" = "3",
                                                                   "4" = "4",
                                                                   "5" = "5",
                                                                   "6" = "6",
                                                                   "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(X_max_AIS_thorax = recode_factor(X_max_AIS_thorax,
                                                                     "keiner" = "none",
                                                                     "1" = "1",
                                                                     "2" = "2", 
                                                                     "3" = "3",
                                                                     "4" = "4",
                                                                     "5" = "5",
                                                                     "6" = "6",
                                                                     "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(X_max_AIS_abdomen = recode_factor(X_max_AIS_abdomen,
                                                                     "keiner" = "none",
                                                                     "1" = "1",
                                                                     "2" = "2", 
                                                                     "3" = "3",
                                                                     "4" = "4",
                                                                     "5" = "5",
                                                                     "6" = "6",
                                                                     "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(X_max_AIS_pelvis = recode_factor(X_max_AIS_pelvis,
                                                                      "keiner" = "none",
                                                                      "1" = "1",
                                                                      "2" = "2", 
                                                                      "3" = "3",
                                                                      "4" = "4",
                                                                      "5" = "5",
                                                                      "6" = "6",
                                                                      "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(X_max_AIS_spine = recode_factor(X_max_AIS_spine,
                                                                     "keiner" = "none",
                                                                     "1" = "1",
                                                                     "2" = "2", 
                                                                     "3" = "3",
                                                                     "4" = "4",
                                                                     "5" = "5",
                                                                     "6" = "6",
                                                                     "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(X_max_AIS_upper_limb = recode_factor(X_max_AIS_upper_limb,
                                                                    "keiner" = "none",
                                                                    "1" = "1",
                                                                    "2" = "2", 
                                                                    "3" = "3",
                                                                    "4" = "4",
                                                                    "5" = "5",
                                                                    "6" = "6",
                                                                    "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(X_max_AIS_lower_limb = recode_factor(X_max_AIS_lower_limb,
                                                                         "keiner" = "none",
                                                                         "1" = "1",
                                                                         "2" = "2", 
                                                                         "3" = "3",
                                                                         "4" = "4",
                                                                         "5" = "5",
                                                                         "6" = "6",
                                                                         "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(X_max_AIS_soft_tissue = recode_factor(X_max_AIS_soft_tissue,
                                                                         "keiner" = "none",
                                                                         "1" = "1",
                                                                         "2" = "2", 
                                                                         "3" = "3",
                                                                         "4" = "4",
                                                                         "5" = "5",
                                                                         "6" = "6",
                                                                         "Nicht verfügbar" = "not_available"))


clean_data <- clean_data %>% mutate(X_ISS = if_else(grepl("Nicht verfügbar", X_ISS), NA_character_, X_ISS))
clean_data$X_ISS <- as.numeric(clean_data$X_ISS)

clean_data <- clean_data %>% mutate(X_broken_ribs_6plus = recode_factor(X_broken_ribs_6plus,
                                                                        "Nein" = "no",
                                                                        "Ja" = "yes",
                                                                        "Nicht verfügbar" = "not_available"))

clean_data <- clean_data %>% mutate(X_bilaterial_rib_fractures = recode_factor(X_bilaterial_rib_fractures,
                                                                        "Nein" = "no",
                                                                        "Ja" = "yes",
                                                                        "Nicht verfügbar" = "not_available"))

clean_data <- clean_data %>% mutate(X_flail_chest = recode_factor(X_flail_chest,
                                                                              "Nein" = "no",
                                                                              "Ja" = "yes",
                                                                              "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(X_dislogged_ribs_3plus = recode_factor(X_dislogged_ribs_3plus,
                                                                 "Nein" = "no",
                                                                 "Ja" = "yes",
                                                                 "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(X_fracture_first_rib = recode_factor(X_fracture_first_rib,
                                                                           "Nein" = "no",
                                                                           "Ja" = "yes",
                                                                           "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(X_rib_fracture_every_region = recode_factor(X_rib_fracture_every_region,
                                                                         "Nein" = "no",
                                                                         "Ja" = "yes",
                                                                         "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(X_Horowitz_quotient = recode_factor(X_Horowitz_quotient,
                                                                          ">400" = "geq400",
                                                                        "300-400" = "300_400",
                                                                        "150-200" = "150_200",
                                                                        "200-300" = "200_300",
                                                                        "<150" = "leq150",
                                                                        "Nicht verfügbar" = "not_available"))
clean_data <- clean_data %>% mutate(X_num_broken_ribs = recode_factor(X_num_broken_ribs,
                                                                        "0" = "0",
                                                                      "1-3" = "1_3",
                                                                      "> 3 bilateral" = "geq_3_bilateral",
                                                                      "> 3 unilateral" = "geq_3_unilateral",
                                                                      "flail chest" = "flail_chest",
                                                                        "Nicht verfügbar" = "not_available"))

clean_data <- clean_data %>% mutate(X_lungcontusion = recode_factor(X_lungcontusion,
                                                                      "1 Lappen" = "1_lobe",
                                                                    "bilateral jeweils < 2 Lappen" = "bilateral_leq_2_lobes_each",
                                                                    "keine" = "none",
                                                                    "unilateral bilobär / bilateral unilobär" = "unilateral_bilobe_bilateral_unilobe",
                                                                    "bilateral jeweils ≥ 2 Lappen" = "bilateral_geq_2_lobes_each",
                                                                      "Nicht verfügbar" = "not_available"))

clean_data <- clean_data %>% mutate(X_pleural_involvement = recode_factor(X_pleural_involvement,
                                                                    "Pneumothorax" = "ptx",
                                                                    "Spannungspneumothorax" = "tension_ptx",
                                                                    "unilateral Hämatothorax/ Hämatopneumothorax" = "unilateral_htx_ptx",
                                                                    "keine" = "none",
                                                                    "bilateral Hämatothorax/ Hämatopneumothorax" = "bilateral_htx_ptx",
                                                                    "Nicht verfügbar" = "not_available"))

clean_data <- clean_data %>% mutate(X_PTX_side = recode_factor(X_PTX_side,
                                                                          "rechts" = "right",
                                                               "beidseits" = "both",
                                                               "links" = "left",
                                                               "keiner" = "none",
                                                               "Nicht zutreffend" = "not_applicable",
                                                                "Nicht verfügbar" = "not_available"))

clean_data$X_PTX_size_left <- ifelse(clean_data$X_PTX_side == "right" | clean_data$X_PTX_side == "none", "not_applicable", clean_data$X_PTX_size_left)
clean_data$X_PTX_size_right <- ifelse(clean_data$X_PTX_side == "left" | clean_data$X_PTX_side == "none", "not_applicable", clean_data$X_PTX_size_right)
clean_data <- clean_data %>% mutate(X_PTX_size_left = replace_na(X_PTX_size_left, "not_available"))
clean_data <- clean_data %>% mutate(X_PTX_size_right = replace_na(X_PTX_size_right, "not_available"))
clean_data <- clean_data %>% mutate(X_PTX_size_right = recode_factor(X_PTX_size_right,
                                                               "Minimal" = "minimal",
                                                               "Mäßig" = "medium",
                                                               "Schwer" = "large",
                                                               "Spannungspneumothorax"  = "tension_ptx",
                                                               "not_applicable" = "not_applicable",
                                                               "Nicht verfügbar" = "not_available"))

clean_data$X_RibScore <- as.factor(clean_data$X_RibScore)



clean_data <- clean_data %>% mutate(X_PTX_size_left = recode_factor(X_PTX_size_left,
                                                                     "Minimal" = "minimal",
                                                                     "Mäßig" = "medium",
                                                                     "Schwer" = "large",
                                                                     "Spannungspneumothorax"  = "tension_ptx",
                                                                    "not_applicable" = "not_applicable",
                                                                     "Nicht verfügbar" = "not_available"))

clean_data <- clean_data %>% mutate(X_soft_tissue_emphysema = recode_factor(X_soft_tissue_emphysema,
                                                                    "keins" = "none",
                                                                    "Minimal" = "minimal",
                                                                    "Mäßig" = "mdium",
                                                                    "Schwer" = "large",
                                                                    "Nicht verfügbar" = "not_available"))

clean_data <- clean_data %>% mutate(X_HTX_side = replace_na(X_HTX_side, "not_available"))
clean_data <- clean_data %>% mutate(X_HTX_side = recode_factor(X_HTX_side,
                                                               "keiner" = "none",
                                                               "links" = "left",
                                                               "rechts" = "right",
                                                               "beidseits" = "both",
                                                                "Nicht verfügbar" = "not_available"))
clean_data$X_HTX_size_right <- ifelse(clean_data$X_HTX_side != "right", "not_applicable", clean_data$X_HTX_size_right)
clean_data <- clean_data %>% mutate(X_HTX_size_right = recode_factor(X_HTX_size_right,
                                                               "Minimal" = "minimal",
                                                               "Mäßig" = "medium",
                                                               "Schwer" = "large",
                                                               "not_applicable" = "not_applicable"))

clean_data$X_HTX_size_left <- ifelse(clean_data$X_HTX_side != "left", "not_applicable", clean_data$X_HTX_size_left)
clean_data <- clean_data %>% mutate(X_HTX_size_left = recode_factor(X_HTX_size_left,
                                                                     "Minimal" = "minimal",
                                                                     "Mäßig" = "medium",
                                                                     "Schwer" = "large",
                                                                     "not_applicable" = "not_applicable",
                                                                    "Nich verfügbar" = "not_available"))

clean_data <- clean_data %>% mutate(X_ASA = recode_factor(X_ASA,
                                                            "1" = "1",
                                                          "2" = "2",
                                                          "3" = "3",
                                                          "4" = "4",
                                                          "Nicht verfügbar" = "not_available"))

clean_data <- clean_data %>% mutate(X_antikoagulation_antiplatelet = replace_na(X_antikoagulation_antiplatelet, "keine"))
clean_data$X_antikoagulation_antiplatelet <- as.factor(clean_data$X_antikoagulation_antiplatelet)

clean_data <- clean_data %>% mutate(X_known_preconditions = replace_na(X_known_preconditions, "not_available"))
clean_data <- clean_data %>% mutate(X_known_preconditions = recode_factor(X_known_preconditions,
                                                          "Nein" = "no",
                                                          "Ja" = "yes",
                                                          "Nicht verfügbar" = "not_available"))

########################
precondition_cols = c("X_heart_insufficiency", 
                      "X_cardiac_dysrhythmia",
                      "X_heart_valve_disease",
                      "X_pulmonary_circulation_disease",
                      "X_vascular_disease" ,
                      "X_arterial_hypertension",
                      "X_plegia",
                      "X_neurodegenerative_disease", 
                      "X_chronic_lung_disease",  
                      "X_diabetes",       
                      "X_Hypothyroidism",
                      "X_Renal_insufficiency",
                      "X_liver_disease",    
                      "X_AIDS_HIV",         
                      "X_lymphoma",       
                      "X_metastatic_tumor", 
                      "X_non_metastatic_tumor",
                      "X_Rheumatoid_arthritis_collagen_vascular_disease", 
                      "X_coagulopathy",      
                      "X_obesity",         
                      "X_unintential_weight_loss", 
                      "X_fluid_electrolyte_disorder",
                      "X_hemorrhagic_anemia",
                      "X_drug_abuse",       
                      "X_psychosis",        
                      "X_depression")

clean_data <- clean_data %>%
  mutate(across(
    all_of(precondition_cols),
    ~ ifelse(clean_data$X_known_preconditions == "no", "not_applicable", .x)
  ))
clean_data <- clean_data %>%
  mutate(across(
    all_of(precondition_cols),
    ~ replace_na(.x,  "not_available")
  ))
clean_data <- clean_data %>%
  mutate(across(
    all_of(precondition_cols),
    ~ recode_factor(.x, "Nein" = "no", "Ja" = "yes", "Nicht verfügbar" = "not_available", "not_applicable" = "not_applicable")
  ))

clean_data <- clean_data %>% mutate(X_age_grouped = recode_factor(X_age_grouped,
                                                                   "0-40" = "0_40",
                                                                  "40-55" = "40_55",
                                                                  "55-70" = "55_70",
                                                                  "70-100" = "70_100"))

chest_tube_prediction_df <- clean_data
chest_tube_prediction_df <- chest_tube_prediction_df %>% select("patient_id",
                                                                "Y_ICD_S22_41",
                                                                "Y_ICD_S22_42",
                                                                "Y_ICD_S22_43",
                                                                "Y_ICD_S22_44",
                                                                "Y_ICD_S22_5",
                                                                "Y_ICD_S27_0",
                                                                "Y_ICD_S27_1",
                                                                "Y_ICD_S27_2",
                                                                "X_gender",
                                                                "P_chest_tube",
                                                                "P_chest_tube_side",
                                                                "P_chest_tube_indication_right",
                                                                "P_chest_tube_indication_left",
                                                                "X_max_AIS_head",
                                                                "X_max_AIS_face",
                                                                "X_max_AIS_throat",
                                                                "X_max_AIS_abdomen",
                                                                "X_max_AIS_pelvis",
                                                                "X_max_AIS_spine",
                                                                "X_max_AIS_upper_limb",
                                                                "X_max_AIS_lower_limb",
                                                                "X_max_AIS_soft_tissue",
                                                                "X_ISS",
                                                                "X_broken_ribs_6plus",
                                                                "X_bilaterial_rib_fractures",
                                                                "X_flail_chest",
                                                                "X_dislogged_ribs_3plus",
                                                                "X_fracture_first_rib",
                                                                "X_rib_fracture_every_region",
                                                                "X_Horowitz_quotient",
                                                                "X_num_broken_ribs",
                                                                "X_lungcontusion",
                                                                "X_pleural_involvement",
                                                                "X_PTX_side",
                                                                "X_PTX_size_right",
                                                                "X_PTX_size_left" ,
                                                                "X_soft_tissue_emphysema",
                                                                "X_HTX_side",
                                                                "X_HTX_size_right",
                                                                "X_HTX_size_left",
                                                                "X_RibScore",
                                                                "X_ASA",
                                                                "X_pulmonary_circulation_disease",
                                                                "X_heart_insufficiency",
                                                                "X_diabetes",
                                                                "X_Renal_insufficiency",
                                                                "X_chronic_lung_disease",
                                                                "X_obesity",
                                                                "X_Elixhauser",
                                                                "X_TTSS",
                                                                "X_age_grouped")
write_xlsx(clean_data, "full_data_cleaned.xlx")
write_xlsx(chest_tube_prediction_df, "full_data_chest_tube_prediction.xlsx")







