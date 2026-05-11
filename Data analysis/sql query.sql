-- Occupation summary
CREATE TABLE IF NOT EXISTS occupation_summary AS
SELECT Occupation,
    COUNT(*) as count,
    ROUND(AVG("Sleep Duration"), 2) as avg_sleep,
    ROUND(AVG("Quality of Sleep"), 2) as avg_quality,
    ROUND(AVG("Stress Level"), 2) as avg_stress,
    ROUND(AVG("Heart Rate"), 2) as avg_heart_rate
FROM sleep_health
GROUP BY Occupation
ORDER BY avg_stress DESC;

-- BMI summary
CREATE TABLE IF NOT EXISTS bmi_summary AS
SELECT 
    CASE WHEN "BMI Category" = 'Normal Weight' THEN 'Normal' 
    ELSE "BMI Category" END as bmi_category,
    COUNT(*) as count,
    ROUND(AVG("Sleep Duration"), 2) as avg_sleep,
    ROUND(AVG("Quality of Sleep"), 2) as avg_quality,
    ROUND(AVG("Stress Level"), 2) as avg_stress
FROM sleep_health
GROUP BY bmi_category;

-- Gender summary
CREATE TABLE IF NOT EXISTS gender_summary AS
SELECT Gender,
    COUNT(*) as count,
    ROUND(AVG("Sleep Duration"), 2) as avg_sleep,
    ROUND(AVG("Quality of Sleep"), 2) as avg_quality,
    ROUND(AVG("Stress Level"), 2) as avg_stress,
    ROUND(AVG("Daily Steps"), 2) as avg_daily_steps
FROM sleep_health
GROUP BY Gender;

-- Age group summary
CREATE TABLE IF NOT EXISTS age_summary AS
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 40 THEN '30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE 'Over 50'
    END as age_group,
    COUNT(*) as count,
    ROUND(AVG("Sleep Duration"), 2) as avg_sleep,
    ROUND(AVG("Quality of Sleep"), 2) as avg_quality,
    ROUND(AVG("Stress Level"), 2) as avg_stress
FROM sleep_health
GROUP BY age_group;

-- Heart disease summary
CREATE TABLE IF NOT EXISTS heart_summary AS
SELECT HeartDisease,
    COUNT(*) as count,
    ROUND(AVG(BMI), 2) as avg_bmi,
    ROUND(AVG(SleepTime), 2) as avg_sleep,
    ROUND(AVG(PhysicalHealth), 2) as avg_physical_health,
    ROUND(AVG(MentalHealth), 2) as avg_mental_health
FROM heart_disease
GROUP BY HeartDisease;

-- Smoking summary
CREATE TABLE IF NOT EXISTS smoking_summary AS
SELECT HeartDisease, Smoking,
    COUNT(*) as count,
    ROUND(AVG(BMI), 2) as avg_bmi
FROM heart_disease
GROUP BY HeartDisease, Smoking;

-- Age and heart disease summary
CREATE TABLE IF NOT EXISTS age_heart_summary AS
SELECT AgeCategory,
    COUNT(*) as total,
    SUM(CASE WHEN HeartDisease = 'Yes' THEN 1 ELSE 0 END) as heart_disease_count,
    ROUND(100.0 * SUM(CASE WHEN HeartDisease = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as heart_disease_pct
FROM heart_disease
GROUP BY AgeCategory
ORDER BY heart_disease_pct DESC;

-- Diabetes summary
CREATE TABLE IF NOT EXISTS diabetes_summary AS
SELECT Diabetic, HeartDisease,
    COUNT(*) as count,
    ROUND(AVG(BMI), 2) as avg_bmi,
    ROUND(AVG(SleepTime), 2) as avg_sleep
FROM heart_disease
GROUP BY Diabetic, HeartDisease;