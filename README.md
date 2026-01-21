# SQL Project: F1 "True Performance" Index

Main Objective: To create an analytical ranking of Formula 1 drivers that isolates driver skill from car performance. The goal is to answer the fundamental question: Who is the best driver, rather than who has the fastest car?

**Technologies: DuckDB, SQL, Jupyter Notebook. Data Source: Ergast F1 Dataset (Kaggle).**

## Chapter 1: The Dominance Index (Teammate Comparison)

Business Goal: Calculate the percentage of total team points scored by a specific driver in each season. In Formula 1, the teammate is the only valid benchmark because they operate identical machinery.

Key SQL Skills Learned:

- Window Functions (OVER, PARTITION BY): Used to calculate the sum of team points without grouping (flattening) the rows.

- CTEs (WITH): Used to build readable, multi-step queries.

- Data Type Casting & Math: Handling division by zero (NULLIF) and floating-point operations.

- CREATE TABLE AS: Persisting calculation results into the database memory.

Tasks:

- Prepare the main denormalized dataset (Joins: results, drivers, constructors, races).

- Calculate the total team points for every race (Window Function).

- Seasonal Aggregation: Calculate the average percentage share of team points for every driver per season.

- Output: Create a dominance_stats table containing: driver_name, season, and dominance_score (e.g., 0.75 means the driver scored 75% of the team's points).

## Chapter 2: The Racecraft Index (Position Gain)

Business Goal: Identify drivers who systematically finish races in a higher position than they started. This metric aims to filter out "one-lap wonders" (drivers with good qualifying pace but poor race management) and highlight those with strong overtaking abilities.

Key SQL Skills Learned:

- Data Cleaning & Filtering (WHERE, LIKE): Working with "dirty" data—specifically excluding mechanical failures (DNF) to ensure drivers are not penalized for engine reliability issues.

- Conditional Aggregation (HAVING): Filtering out statistically insignificant data points (e.g., drivers who competed in fewer than 20 races).

- Arithmetic Logic: Creating a Delta metric (Grid Position - Finishing Position).

- String Manipulation: Analyzing textual status descriptions.

Tasks:

- Analyze the status table: Identify IDs representing a completed race (e.g., "Finished", "+1 Lap").

- Create a query calculating positions_gained for every valid race.

- Aggregation: Calculate the average positions gained for drivers meeting the minimum race count threshold.

- Output: Create a racecraft_stats table with the avg_positions_gained column.

## Chapter 3: The Ultimate Ranking (Composite Score)

Business Goal: Create a single, synthetic score that allows for the comparison of drivers across different eras and teams, combining the insights from Chapters 1 and 2.

Key SQL Skills Learned:

- Advanced Joins: Joining the aggregated tables from Chapter 1 and Chapter 2.

- Ranking Window Functions (RANK, DENSE_RANK): Generating a leaderboard based on the new composite metric.

- Complex Logic (CASE WHEN): Assigning weights to different metrics (e.g., weighting Dominance higher than Racecraft).

- Views / Reporting: Preparing the final, clean dataset for presentation.

Tasks:

- Join dominance_stats and racecraft_stats by driver name/ID.

- Define a scoring formula: Total Score = (Dominance * 0,7) + (Avg Positions Gained * 0,3).

- Generate a "Top 10 All-Time" ranking based on the algorithm.

- Analysis: Compare the generated ranking against official championship titles to derive business insights.

TO DO:
- Make analysis of Driver Dominance and Position Gain - show why those drivers are on top of these metrics
- make wages for Position Gain -> that will prevent situation where somebody who was on 20 place and gained 4 places is the same as from 4->1 place


