--6.	Create a view for yearly crop summary (total area, production, yield).
CREATE VIEW Yearly_Crop_Summary AS
SELECT 
    Year,
    State_Name,
    
    -- Total Area across all crops (in 1000 ha)
    (
        ISNULL(RICE_AREA_1000_ha, 0) + ISNULL(WHEAT_AREA_1000_ha, 0) +
        ISNULL(KHARIF_SORGHUM_AREA_1000_ha, 0) + ISNULL(RABI_SORGHUM_AREA_1000_ha, 0) +
        ISNULL(SORGHUM_AREA_1000_ha, 0) + ISNULL(PEARL_MILLET_AREA_1000_ha, 0) +
        ISNULL(MAIZE_AREA_1000_ha, 0) + ISNULL(FINGER_MILLET_AREA_1000_ha, 0) +
        ISNULL(BARLEY_AREA_1000_ha, 0) + ISNULL(CHICKPEA_AREA_1000_ha, 0) +
        ISNULL(PIGEONPEA_AREA_1000_ha, 0) + ISNULL(MINOR_PULSES_AREA_1000_ha, 0) +
        ISNULL(GROUNDNUT_AREA_1000_ha, 0) + ISNULL(SESAMUM_AREA_1000_ha, 0) +
        ISNULL(RAPESEED_AND_MUSTARD_AREA_1000_ha, 0) + ISNULL(SAFFLOWER_AREA_1000_ha, 0) +
        ISNULL(CASTOR_AREA_1000_ha, 0) + ISNULL(LINSEED_AREA_1000_ha, 0) +
        ISNULL(SUNFLOWER_AREA_1000_ha, 0) + ISNULL(SOYABEAN_AREA_1000_ha, 0) +
        ISNULL(OILSEEDS_AREA_1000_ha, 0) + ISNULL(SUGARCANE_AREA_1000_ha, 0) +
        ISNULL(COTTON_AREA_1000_ha, 0) + ISNULL(FRUITS_AREA_1000_ha, 0) +
        ISNULL(VEGETABLES_AREA_1000_ha, 0) + ISNULL(FRUITS_AND_VEGETABLES_AREA_1000_ha, 0) +
        ISNULL(POTATOES_AREA_1000_ha, 0) + ISNULL(ONION_AREA_1000_ha, 0) +
        ISNULL(FODDER_AREA_1000_ha, 0)
    ) AS Total_Area_1000_ha,

    -- Total Production across all crops (in 1000 tons)
    (
        ISNULL(RICE_PRODUCTION_1000_tons, 0) + ISNULL(WHEAT_PRODUCTION_1000_tons, 0) +
        ISNULL(KHARIF_SORGHUM_PRODUCTION_1000_tons, 0) + ISNULL(RABI_SORGHUM_PRODUCTION_1000_tons, 0) +
        ISNULL(SORGHUM_PRODUCTION_1000_tons, 0) + ISNULL(PEARL_MILLET_PRODUCTION_1000_tons, 0) +
        ISNULL(MAIZE_PRODUCTION_1000_tons, 0) + ISNULL(FINGER_MILLET_PRODUCTION_1000_tons, 0) +
        ISNULL(BARLEY_PRODUCTION_1000_tons, 0) + ISNULL(CHICKPEA_PRODUCTION_1000_tons, 0) +
        ISNULL(PIGEONPEA_PRODUCTION_1000_tons, 0) + ISNULL(MINOR_PULSES_PRODUCTION_1000_tons, 0) +
        ISNULL(GROUNDNUT_PRODUCTION_1000_tons, 0) + ISNULL(SESAMUM_PRODUCTION_1000_tons, 0) +
        ISNULL(RAPESEED_AND_MUSTARD_PRODUCTION_1000_tons, 0) + ISNULL(SAFFLOWER_PRODUCTION_1000_tons, 0) +
        ISNULL(CASTOR_PRODUCTION_1000_tons, 0) + ISNULL(LINSEED_PRODUCTION_1000_tons, 0) +
        ISNULL(SUNFLOWER_PRODUCTION_1000_tons, 0) + ISNULL(SOYABEAN_PRODUCTION_1000_tons, 0) +
        ISNULL(OILSEEDS_PRODUCTION_1000_tons, 0) + ISNULL(SUGARCANE_PRODUCTION_1000_tons, 0) +
        ISNULL(COTTON_PRODUCTION_1000_tons, 0)
    ) AS Total_Production_1000_tons,

    -- Total Yield (tons/ha)
    CASE 
        WHEN (
            ISNULL(RICE_AREA_1000_ha, 0) + ISNULL(WHEAT_AREA_1000_ha, 0) +
            ISNULL(KHARIF_SORGHUM_AREA_1000_ha, 0) + ISNULL(RABI_SORGHUM_AREA_1000_ha, 0) +
            ISNULL(SORGHUM_AREA_1000_ha, 0) + ISNULL(PEARL_MILLET_AREA_1000_ha, 0) +
            ISNULL(MAIZE_AREA_1000_ha, 0) + ISNULL(FINGER_MILLET_AREA_1000_ha, 0) +
            ISNULL(BARLEY_AREA_1000_ha, 0) + ISNULL(CHICKPEA_AREA_1000_ha, 0) +
            ISNULL(PIGEONPEA_AREA_1000_ha, 0) + ISNULL(MINOR_PULSES_AREA_1000_ha, 0) +
            ISNULL(GROUNDNUT_AREA_1000_ha, 0) + ISNULL(SESAMUM_AREA_1000_ha, 0) +
            ISNULL(RAPESEED_AND_MUSTARD_AREA_1000_ha, 0) + ISNULL(SAFFLOWER_AREA_1000_ha, 0) +
            ISNULL(CASTOR_AREA_1000_ha, 0) + ISNULL(LINSEED_AREA_1000_ha, 0) +
            ISNULL(SUNFLOWER_AREA_1000_ha, 0) + ISNULL(SOYABEAN_AREA_1000_ha, 0) +
            ISNULL(OILSEEDS_AREA_1000_ha, 0) + ISNULL(SUGARCANE_AREA_1000_ha, 0) +
            ISNULL(COTTON_AREA_1000_ha, 0) + ISNULL(FRUITS_AREA_1000_ha, 0) +
            ISNULL(VEGETABLES_AREA_1000_ha, 0) + ISNULL(FRUITS_AND_VEGETABLES_AREA_1000_ha, 0) +
            ISNULL(POTATOES_AREA_1000_ha, 0) + ISNULL(ONION_AREA_1000_ha, 0) +
            ISNULL(FODDER_AREA_1000_ha, 0)
        ) = 0 THEN NULL
        ELSE (
            (
                ISNULL(RICE_PRODUCTION_1000_tons, 0) + ISNULL(WHEAT_PRODUCTION_1000_tons, 0) +
                ISNULL(KHARIF_SORGHUM_PRODUCTION_1000_tons, 0) + ISNULL(RABI_SORGHUM_PRODUCTION_1000_tons, 0) +
                ISNULL(SORGHUM_PRODUCTION_1000_tons, 0) + ISNULL(PEARL_MILLET_PRODUCTION_1000_tons, 0) +
                ISNULL(MAIZE_PRODUCTION_1000_tons, 0) + ISNULL(FINGER_MILLET_PRODUCTION_1000_tons, 0) +
                ISNULL(BARLEY_PRODUCTION_1000_tons, 0) + ISNULL(CHICKPEA_PRODUCTION_1000_tons, 0) +
                ISNULL(PIGEONPEA_PRODUCTION_1000_tons, 0) + ISNULL(MINOR_PULSES_PRODUCTION_1000_tons, 0) +
                ISNULL(GROUNDNUT_PRODUCTION_1000_tons, 0) + ISNULL(SESAMUM_PRODUCTION_1000_tons, 0) +
                ISNULL(RAPESEED_AND_MUSTARD_PRODUCTION_1000_tons, 0) + ISNULL(SAFFLOWER_PRODUCTION_1000_tons, 0) +
                ISNULL(CASTOR_PRODUCTION_1000_tons, 0) + ISNULL(LINSEED_PRODUCTION_1000_tons, 0) +
                ISNULL(SUNFLOWER_PRODUCTION_1000_tons, 0) + ISNULL(SOYABEAN_PRODUCTION_1000_tons, 0) +
                ISNULL(OILSEEDS_PRODUCTION_1000_tons, 0) + ISNULL(SUGARCANE_PRODUCTION_1000_tons, 0) +
                ISNULL(COTTON_PRODUCTION_1000_tons, 0)
            ) /
            (
                ISNULL(RICE_AREA_1000_ha, 0) + ISNULL(WHEAT_AREA_1000_ha, 0) +
                ISNULL(KHARIF_SORGHUM_AREA_1000_ha, 0) + ISNULL(RABI_SORGHUM_AREA_1000_ha, 0) +
                ISNULL(SORGHUM_AREA_1000_ha, 0) + ISNULL(PEARL_MILLET_AREA_1000_ha, 0) +
                ISNULL(MAIZE_AREA_1000_ha, 0) + ISNULL(FINGER_MILLET_AREA_1000_ha, 0) +
                ISNULL(BARLEY_AREA_1000_ha, 0) + ISNULL(CHICKPEA_AREA_1000_ha, 0) +
                ISNULL(PIGEONPEA_AREA_1000_ha, 0) + ISNULL(MINOR_PULSES_AREA_1000_ha, 0) +
                ISNULL(GROUNDNUT_AREA_1000_ha, 0) + ISNULL(SESAMUM_AREA_1000_ha, 0) +
                ISNULL(RAPESEED_AND_MUSTARD_AREA_1000_ha, 0) + ISNULL(SAFFLOWER_AREA_1000_ha, 0) +
                ISNULL(CASTOR_AREA_1000_ha, 0) + ISNULL(LINSEED_AREA_1000_ha, 0) +
                ISNULL(SUNFLOWER_AREA_1000_ha, 0) + ISNULL(SOYABEAN_AREA_1000_ha, 0) +
                ISNULL(OILSEEDS_AREA_1000_ha, 0) + ISNULL(SUGARCANE_AREA_1000_ha, 0) +
                ISNULL(COTTON_AREA_1000_ha, 0) + ISNULL(FRUITS_AREA_1000_ha, 0) +
                ISNULL(VEGETABLES_AREA_1000_ha, 0) + ISNULL(FRUITS_AND_VEGETABLES_AREA_1000_ha, 0) +
                ISNULL(POTATOES_AREA_1000_ha, 0) + ISNULL(ONION_AREA_1000_ha, 0) +
                ISNULL(FODDER_AREA_1000_ha, 0)
            )
        )
    END AS Total_Yield_tons_per_ha
FROM agri_rain;
select* from Yearly_crop_summary;