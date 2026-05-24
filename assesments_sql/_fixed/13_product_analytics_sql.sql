-- ============================================
-- ASSESSMENT: SQL
-- CATEGORY: Product Analytics
-- TOTAL QUESTIONS: 35
-- DIFFICULTY: ~10 foundational, ~18 intermediate, ~7 advanced
-- ============================================

DO $$
DECLARE
    v_sub_skill_id UUID;
    v_q_id UUID;
BEGIN
    -- Look up the sub-skill ID
    SELECT id INTO v_sub_skill_id
    FROM sub_skills
    WHERE slug = 'sql';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug sql not found. Run the seed data first.';
    END IF;

    -- ----------------------------------------
    -- QUESTION 1 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        1,
        'Netflix''s COUNT Logic',
        'Netflix''s Growth PM wants to know how many users have actually set a profile avatar. The users table has 200 million rows. The avatar_url column is NULL for users who haven''t set one. Which query accurately counts only the users with avatars?',
        'foundational',
        'Netflix',
        'Growth and user profile completion',
        'A',
        'Using COUNT(column_name) counts only the non-null values in that specific column, making it the perfect approach for this scenario. COUNT(*) counts every single row regardless of NULLs. SUM() is used for numeric addition, not row counting. Counting DISTINCT user_ids wouldn''t verify if the avatar itself is null.',
        ARRAY['sql', 'aggregations', 'count']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'SELECT COUNT(avatar_url) FROM users;', true),
    (v_q_id, 'B', 'SELECT COUNT(*) FROM users WHERE avatar_url = '''';', false),
    (v_q_id, 'C', 'SELECT SUM(avatar_url) FROM users;', false),
    (v_q_id, 'D', 'SELECT COUNT(DISTINCT user_id) FROM users;', false);

    -- ----------------------------------------
    -- QUESTION 2 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        2,
        'Spotify''s HAVING Filter',
        'Spotify''s PM is analyzing heavy listeners to target for a new premium tier. They need to find users who listened to more than 500 unique songs this month. Which clause correctly applies this filter?',
        'foundational',
        'Spotify',
        'Premium targeting based on behavior',
        'B',
        'The HAVING clause is specifically designed to filter on aggregated metrics (like COUNT or SUM) after a GROUP BY is applied. The WHERE clause filters individual rows before aggregation occurs, so placing an aggregate function inside WHERE throws a syntax error.',
        ARRAY['sql', 'filtering', 'having']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'WHERE COUNT(DISTINCT song_id) > 500', false),
    (v_q_id, 'B', 'HAVING COUNT(DISTINCT song_id) > 500', true),
    (v_q_id, 'C', 'HAVING SUM(song_id) > 500', false),
    (v_q_id, 'D', 'WHERE song_id > 500', false);

    -- ----------------------------------------
    -- QUESTION 3 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        3,
        'Uber''s Revenue Aggregation',
        'Uber''s Pricing PM wants to find the total revenue generated from surges in New York. Which query correctly calculates this gross metric?',
        'foundational',
        'Uber',
        'Pricing and revenue tracking',
        'C',
        'SUM() is the standard SQL aggregate function used to add up numeric values across rows. COUNT() would just return the number of rides, not the monetary total. TOTAL() is not a standard SQL function, and MAX() only returns the single highest fee.',
        ARRAY['sql', 'aggregations', 'sum']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'SELECT COUNT(surge_fee) FROM rides WHERE city = ''New York'';', false),
    (v_q_id, 'B', 'SELECT TOTAL(surge_fee) FROM rides WHERE city = ''New York'';', false),
    (v_q_id, 'C', 'SELECT SUM(surge_fee) FROM rides WHERE city = ''New York'';', true),
    (v_q_id, 'D', 'SELECT MAX(surge_fee) FROM rides WHERE city = ''New York'';', false);

    -- ----------------------------------------
    -- QUESTION 4 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        4,
        'Airbnb''s GROUP BY Clause',
        'Airbnb''s Trust PM wants to see the total number of guest complaints broken down by country to identify problematic regions. Which query structure is required?',
        'foundational',
        'Airbnb',
        'Trust and safety monitoring',
        'D',
        'Whenever you select a non-aggregated column (like country) alongside an aggregated metric (like COUNT), you must explicitly group by the non-aggregated column using GROUP BY. Failing to do so causes a syntax error in PostgreSQL.',
        ARRAY['sql', 'group_by']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'SELECT country, COUNT(complaint_id) FROM complaints;', false),
    (v_q_id, 'B', 'SELECT country, SUM(complaint_id) FROM complaints GROUP BY country;', false),
    (v_q_id, 'C', 'SELECT country, COUNT(complaint_id) FROM complaints ORDER BY country;', false),
    (v_q_id, 'D', 'SELECT country, COUNT(complaint_id) FROM complaints GROUP BY country;', true);

    -- ----------------------------------------
    -- QUESTION 5 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        5,
        'Stripe''s LEFT JOIN Application',
        'Stripe''s PM wants to list all connected businesses alongside their payment volume. They explicitly need to include businesses that haven''t processed any payments yet. Which join type is appropriate?',
        'foundational',
        'Stripe',
        'Merchant onboarding and activity',
        'A',
        'A LEFT JOIN returns all rows from the left table (businesses) and the matching rows from the right table (payments). If there is no match, it returns NULL for the right side, successfully including businesses with zero payments. An INNER JOIN would drop them.',
        ARRAY['sql', 'joins', 'left_join']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'LEFT JOIN payments ON businesses.id = payments.business_id', true),
    (v_q_id, 'B', 'INNER JOIN payments ON businesses.id = payments.business_id', false),
    (v_q_id, 'C', 'RIGHT JOIN payments ON businesses.id = payments.business_id', false),
    (v_q_id, 'D', 'CROSS JOIN payments', false);

    -- ----------------------------------------
    -- QUESTION 6 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        6,
        'Slack''s Date Truncation',
        'Slack''s PM wants to count how many workspaces were created strictly in the previous calendar month. Which filtering approach is most robust?',
        'foundational',
        'Slack',
        'Workspace creation analytics',
        'B',
        'Using DATE_TRUNC(''month'', CURRENT_DATE) safely isolates exact calendar month boundaries regardless of month length. Subtracting 30 days is inaccurate for months like February or August, and extracting the month integer fails at the change of a year.',
        ARRAY['sql', 'dates', 'date_trunc']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'WHERE created_at = CURRENT_DATE - 30', false),
    (v_q_id, 'B', 'WHERE created_at >= DATE_TRUNC(''month'', CURRENT_DATE - INTERVAL ''1 month'') AND created_at < DATE_TRUNC(''month'', CURRENT_DATE)', true),
    (v_q_id, 'C', 'WHERE created_at BETWEEN ''last month'' AND ''this month''', false),
    (v_q_id, 'D', 'WHERE EXTRACT(MONTH FROM created_at) = EXTRACT(MONTH FROM CURRENT_DATE) - 1', false);

    -- ----------------------------------------
    -- QUESTION 7 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        7,
        'Shopify''s NULL Handling',
        'Shopify''s PM is calculating total cart value. Some users apply a discount, but most don''t, leaving the discount_amount column as NULL. If the PM subtracts discount_amount from subtotal, the math yields NULL. How should they handle this?',
        'foundational',
        'Shopify',
        'Checkout and discounting logic',
        'C',
        'COALESCE() evaluates the arguments in order and returns the first non-null value. COALESCE(discount_amount, 0) safely converts NULL discounts into 0, allowing the math to compute properly. ISNULL is not a standard PostgreSQL function for this.',
        ARRAY['sql', 'functions', 'coalesce']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use ISNULL(discount_amount) to convert it to a boolean.', false),
    (v_q_id, 'B', 'Use REPLACE(discount_amount, NULL, 0).', false),
    (v_q_id, 'C', 'Wrap discount_amount in COALESCE(discount_amount, 0).', true),
    (v_q_id, 'D', 'Change the table schema to drop the column.', false);

    -- ----------------------------------------
    -- QUESTION 8 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        8,
        'DoorDash''s Top Leaderboard',
        'DoorDash''s Marketing PM wants to reward the top 10 dashers based on their total completed deliveries. Which syntax correctly returns this leaderboard?',
        'foundational',
        'DoorDash',
        'Dasher performance marketing',
        'D',
        'To get a "Top N" list in PostgreSQL, you sort the metric in descending order using ORDER BY DESC, and then restrict the row count using LIMIT. Using ASC would return the bottom 10. TOP 10 is SQL Server (T-SQL) syntax, not standard PostgreSQL.',
        ARRAY['sql', 'sorting', 'limit']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'ORDER BY completed_deliveries ASC LIMIT 10', false),
    (v_q_id, 'B', 'LIMIT 10 ORDER BY completed_deliveries DESC', false),
    (v_q_id, 'C', 'TOP 10 ORDER BY completed_deliveries DESC', false),
    (v_q_id, 'D', 'ORDER BY completed_deliveries DESC LIMIT 10', true);

    -- ----------------------------------------
    -- QUESTION 9 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        9,
        'Tinder''s Missing Values',
        'Tinder''s Onboarding PM wants to find users who skipped writing a bio during sign-up to send them a push notification. The database stores this as a true missing value. How do you filter for this?',
        'foundational',
        'Tinder',
        'User profile completion',
        'A',
        'In SQL, NULL represents an unknown value. Because it is unknown, you cannot use standard equality operators like = to evaluate it. You must use the special IS NULL or IS NOT NULL operators.',
        ARRAY['sql', 'filtering', 'nulls']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'WHERE bio IS NULL', true),
    (v_q_id, 'B', 'WHERE bio = NULL', false),
    (v_q_id, 'C', 'WHERE bio = '''' OR bio = NULL', false),
    (v_q_id, 'D', 'WHERE IS_EMPTY(bio)', false);

    -- ----------------------------------------
    -- QUESTION 10 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        10,
        'Figma''s SQL Execution Order',
        'Figma''s PM is writing a query: SELECT team_id, COUNT(file_id) AS total_files FROM files WHERE total_files > 10 GROUP BY team_id. It throws an error. Why?',
        'foundational',
        'Figma',
        'Debugging analytics queries',
        'B',
        'SQL execution order dictates that the WHERE clause is evaluated before the SELECT clause. Therefore, the alias ''total_files'' does not exist yet when WHERE is running. Furthermore, WHERE cannot filter on aggregated data—that requires a HAVING clause.',
        ARRAY['sql', 'execution_order']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'total_files is a reserved keyword in PostgreSQL.', false),
    (v_q_id, 'B', 'You cannot use column aliases in the WHERE clause because WHERE is evaluated before SELECT.', true),
    (v_q_id, 'C', 'GROUP BY must come before the WHERE clause in SQL execution.', false),
    (v_q_id, 'D', 'You must use a HAVING clause, but column aliases are still fully allowed in WHERE.', false);

    -- ----------------------------------------
    -- QUESTION 11 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        11,
        'Notion''s CTE Modularity',
        'Notion''s Analytics PM has a massively complex query with 5 nested subqueries to calculate workspace activity. They want to make it readable and modular for the rest of the team without sacrificing performance. What is the best SQL feature to use?',
        'intermediate',
        'Notion',
        'Query readability and maintenance',
        'C',
        'Common Table Expressions (CTEs), created using the WITH keyword, allow you to define temporary result sets that can be referenced sequentially. This makes complex logic drastically more readable than nested subqueries without requiring physical tables.',
        ARRAY['sql', 'ctes', 'readability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create 5 physical tables and INSERT data into them step by step.', false),
    (v_q_id, 'B', 'Use a UNION ALL statement to string the subqueries together sequentially.', false),
    (v_q_id, 'C', 'Use Common Table Expressions (CTEs) with the WITH keyword to define sequential temporary result sets.', true),
    (v_q_id, 'D', 'Convert the subqueries into Window Functions partitioned by user ID.', false);

    -- ----------------------------------------
    -- QUESTION 12 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        12,
        'WhatsApp''s Self Joins',
        'WhatsApp''s PM is analyzing "close friends" networks. They want to find instances where User A called User B, and User B also called User A. Both events are stored in the same calls table. How should they construct the query?',
        'intermediate',
        'WhatsApp',
        'Network effects and bidirectionality',
        'D',
        'A Self JOIN allows you to join a table to itself. By joining the calls table (t1) to the calls table (t2) where t1.caller_id = t2.receiver_id and vice versa, you can easily pair bidirectional events in a single row without subqueries.',
        ARRAY['sql', 'joins', 'self_join']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use an INNER JOIN between the users table and the calls table.', false),
    (v_q_id, 'B', 'Use a FULL OUTER JOIN on the calls table where the caller IDs match.', false),
    (v_q_id, 'C', 'Use UNION to combine caller_id and receiver_id into a single column.', false),
    (v_q_id, 'D', 'Perform a Self JOIN on the calls table where t1.caller_id = t2.receiver_id AND t1.receiver_id = t2.caller_id.', true);

    -- ----------------------------------------
    -- QUESTION 13 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        13,
        'Amazon''s Deduplication',
        'Amazon''s PM is combining a list of users who bought Kindle books and users who bought physical books to send a generic marketing email. They don''t want to email anyone twice if they happen to appear on both lists. What should they use?',
        'intermediate',
        'Amazon',
        'Marketing email audience generation',
        'A',
        'UNION combines the result sets of two queries and automatically removes exact duplicates. UNION ALL combines them but retains all duplicates, which would result in users receiving the email twice. CROSS JOIN creates a massive Cartesian product.',
        ARRAY['sql', 'unions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use UNION to combine the two queries.', true),
    (v_q_id, 'B', 'Use UNION ALL to combine the two queries.', false),
    (v_q_id, 'C', 'Use a CROSS JOIN between the two user tables.', false),
    (v_q_id, 'D', 'Use CONCAT() on the user IDs from both tables.', false);

    -- ----------------------------------------
    -- QUESTION 14 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        14,
        'Spotify''s Top Song Window',
        'Spotify''s PM wants to find the absolute most listened-to song for each individual user in 2023. Which window function approach isolates exactly one top song per user?',
        'intermediate',
        'Spotify',
        'Personalized wrapping logic',
        'B',
        'ROW_NUMBER() generates a unique sequential integer for each row within a partition. Even in the event of a tie (two songs with the exact same play count), ROW_NUMBER() arbitrarily breaks the tie and assigns 1 and 2, ensuring exactly one top song per user.',
        ARRAY['sql', 'window_functions', 'row_number']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'RANK() OVER(ORDER BY listen_count DESC PARTITION BY user_id) and filter for rank = 1.', false),
    (v_q_id, 'B', 'ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY listen_count DESC) and filter for row_num = 1.', true),
    (v_q_id, 'C', 'MAX(listen_count) OVER(PARTITION BY user_id).', false),
    (v_q_id, 'D', 'LEAD(listen_count) OVER(PARTITION BY user_id ORDER BY date).', false);

    -- ----------------------------------------
    -- QUESTION 15 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        15,
        'Uber''s Leaderboard Rankings',
        'Uber''s PM is creating a leaderboard for driver referrals. If two drivers tie for 1st place with 50 referrals, the PM wants the very next driver (with 49 referrals) to be strictly in 2nd place, not 3rd. Which function supports this?',
        'intermediate',
        'Uber',
        'Driver gamification and leaderboards',
        'C',
        'DENSE_RANK() assigns ranks without skipping numbers when ties occur (1, 1, 2). Standard RANK() would leave a gap after ties, assigning the next person a rank based on their absolute row position (1, 1, 3).',
        ARRAY['sql', 'window_functions', 'rank']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use RANK().', false),
    (v_q_id, 'B', 'Use ROW_NUMBER().', false),
    (v_q_id, 'C', 'Use DENSE_RANK().', true),
    (v_q_id, 'D', 'Use NTILE(10).', false);

    -- ----------------------------------------
    -- QUESTION 16 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        16,
        'Airbnb''s Fan-out Trap',
        'Airbnb''s PM joins the reservations table (1 row per trip) with the guest_reviews table (multiple reviews possible per trip). When they SUM(reservation_price), the total revenue looks artificially massive. What happened?',
        'intermediate',
        'Airbnb',
        'Revenue metric debugging',
        'D',
        'Joining a primary table to a table with multiple matching rows creates a "fan-out" effect, duplicating the primary row. When you sum a metric from the primary table after the join, you multiply the value by the number of joined rows, drastically inflating the sum.',
        ARRAY['sql', 'joins', 'fan_out']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The SUM function automatically added the review ratings to the reservation price.', false),
    (v_q_id, 'B', 'INNER JOIN inherently multiplies numeric columns together to ensure data integrity.', false),
    (v_q_id, 'C', 'The query included canceled reservations that hadn''t been filtered out yet.', false),
    (v_q_id, 'D', 'The 1-to-many JOIN caused rows in the reservations table to duplicate, leading to a fan-out that inflated the sum.', true);

    -- ----------------------------------------
    -- QUESTION 17 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        17,
        'Stripe''s Conditional Aggregation',
        'Stripe''s PM wants to calculate the success rate of API requests per merchant in a single concise query. The status column contains either ''success'' or ''failed''. What is the cleanest approach?',
        'intermediate',
        'Stripe',
        'API reliability and success rates',
        'A',
        'You can aggregate conditional logic by wrapping a CASE statement inside a SUM function. SUM(CASE WHEN condition THEN 1 ELSE 0 END) counts the successes, and dividing by COUNT(*) gives the overall percentage rate. The other options either use invalid syntax or don''t calculate a ratio.',
        ARRAY['sql', 'aggregations', 'case_when']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'SUM(CASE WHEN status = ''success'' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)', true),
    (v_q_id, 'B', 'COUNT(status = ''success'') / COUNT(*)', false),
    (v_q_id, 'C', 'AVG(CASE WHEN status = ''success'' THEN ''yes'' ELSE ''no'' END)', false),
    (v_q_id, 'D', 'SUM(status) / COUNT(status)', false);

    -- ----------------------------------------
    -- QUESTION 18 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        18,
        'Slack''s Anti-Join',
        'Slack''s PM wants to identify "zombie channels" — channels that exist in the channels table but have absolutely no rows in the messages table for the last 30 days. What is the most efficient relational way to find this?',
        'intermediate',
        'Slack',
        'Identifying inactive states',
        'B',
        'An Anti-Join is created by performing a LEFT JOIN to the secondary table and adding a WHERE secondary_id IS NULL clause. This successfully returns only the records from the primary table that have zero matching records in the joined table.',
        ARRAY['sql', 'joins', 'anti_join']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use an INNER JOIN to messages and filter with WHERE messages.count = 0.', false),
    (v_q_id, 'B', 'Use a LEFT JOIN to messages and filter with WHERE messages.id IS NULL.', true),
    (v_q_id, 'C', 'Use a RIGHT JOIN to channels and filter with WHERE channels.id IS NULL.', false),
    (v_q_id, 'D', 'Use FULL OUTER JOIN and filter with WHERE channels.status = ''inactive''.', false);

    -- ----------------------------------------
    -- QUESTION 19 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        19,
        'Shopify''s Moving Average',
        'Shopify''s PM is building a dashboard showing the 7-day trailing moving average of daily GMV (Gross Merchandise Value) to smooth out weekend dips. Which window function achieves this?',
        'intermediate',
        'Shopify',
        'Smoothing volatile daily metrics',
        'C',
        'Window functions can frame specific row sets. ROWS BETWEEN 6 PRECEDING AND CURRENT ROW tells the engine to calculate the AVG over the current row plus the exactly 6 rows prior, perfectly creating a 7-day rolling metric.',
        ARRAY['sql', 'window_functions', 'moving_average']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'AVG(daily_gmv) OVER (PARTITION BY date)', false),
    (v_q_id, 'B', 'SUM(daily_gmv) OVER (ORDER BY date ROWS 7 PRECEDING) / 7', false),
    (v_q_id, 'C', 'AVG(daily_gmv) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)', true),
    (v_q_id, 'D', 'AVG(daily_gmv) OVER (ORDER BY date ROWS BETWEEN CURRENT ROW AND 6 FOLLOWING)', false);

    -- ----------------------------------------
    -- QUESTION 20 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        20,
        'DoorDash''s Week-over-Week Growth',
        'DoorDash''s PM wants to calculate the week-over-week percentage growth in new diners. They have a table grouped by week_start_date with a new_diners column. How can they reference last week''s numbers?',
        'intermediate',
        'DoorDash',
        'Time-series growth analysis',
        'D',
        'The LAG() window function allows you to look backwards in the dataset. By calculating (Current - Previous) / Previous using LAG(new_diners), you correctly yield the percentage growth rate over the time dimension.',
        ARRAY['sql', 'window_functions', 'lag']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '(new_diners - LEAD(new_diners) OVER(ORDER BY week_start_date)) / new_diners', false),
    (v_q_id, 'B', 'LAG(new_diners) OVER(ORDER BY week_start_date) / new_diners', false),
    (v_q_id, 'C', '(new_diners / LAG(new_diners) OVER(ORDER BY week_start_date)) - 100', false),
    (v_q_id, 'D', '(new_diners - LAG(new_diners) OVER(ORDER BY week_start_date)) / LAG(new_diners) OVER(ORDER BY week_start_date)', true);

    -- ----------------------------------------
    -- QUESTION 21 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        21,
        'Tinder''s String Slicing',
        'Tinder''s PM wants to analyze what email domains are most popular among users. They need to extract just "gmail.com" from the full string "user123@gmail.com". How can this be done in standard PostgreSQL?',
        'intermediate',
        'Tinder',
        'User demographic breakdown',
        'A',
        'SUBSTRING combined with POSITION allows you to dynamically slice strings. POSITION finds the exact index of the ''@'' symbol, and extracting everything from that index + 1 returns just the domain.',
        ARRAY['sql', 'string_functions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'SUBSTRING(email FROM POSITION(''@'' IN email) + 1)', true),
    (v_q_id, 'B', 'LEFT(email, POSITION(''@'' IN email))', false),
    (v_q_id, 'C', 'EXTRACT(DOMAIN FROM email)', false),
    (v_q_id, 'D', 'TRIM(LEADING ''@'' FROM email)', false);

    -- ----------------------------------------
    -- QUESTION 22 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        22,
        'Figma''s Load Time Median',
        'Figma''s PM is investigating slow load times. The average load time is 2 seconds, but the PM suspects massive outliers are skewing it. They want the true median load time. What function should they use?',
        'intermediate',
        'Figma',
        'Performance tracking and percentiles',
        'B',
        'PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY column) calculates the continuous 50th percentile (the median) in PostgreSQL. Standard MEDIAN() is not a native function in PG, and AVG() is heavily skewed by outliers.',
        ARRAY['sql', 'aggregations', 'percentiles']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'MEDIAN(load_time)', false),
    (v_q_id, 'B', 'PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY load_time)', true),
    (v_q_id, 'C', 'PERCENTILE(load_time, 50)', false),
    (v_q_id, 'D', 'AVG(load_time) OVER (PARTITION BY user_id)', false);

    -- ----------------------------------------
    -- QUESTION 23 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        23,
        'Notion''s Running Total',
        'Notion''s Growth PM wants to plot a "total users over time" chart, which requires a running cumulative total of daily signups over the course of a year. Which window function generates this?',
        'intermediate',
        'Notion',
        'Growth and user acquisition plotting',
        'C',
        'Using SUM() as a window function combined with ORDER BY date automatically creates a running total. It sums all rows from the beginning of the partition up to the current row''s date. There is no native RUNNING_SUM() function.',
        ARRAY['sql', 'window_functions', 'cumulative_sum']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'SUM(signups) OVER (PARTITION BY date)', false),
    (v_q_id, 'B', 'RUNNING_SUM(signups) OVER (ORDER BY date)', false),
    (v_q_id, 'C', 'SUM(signups) OVER (ORDER BY date)', true),
    (v_q_id, 'D', 'SUM(signups) GROUP BY date', false);

    -- ----------------------------------------
    -- QUESTION 24 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        24,
        'WhatsApp''s Wildcard Search',
        'WhatsApp''s PM is trying to identify users on older iPhone models. They want to match any device string containing "iPhone 8" or "iPhone 7". Which WHERE clause syntax correctly uses wildcards?',
        'intermediate',
        'WhatsApp',
        'Device deprecation targeting',
        'D',
        'The LIKE operator combined with the % wildcard matches any sequence of characters. Wrapping the target string in % (e.g., ''%iPhone 8%'') ensures it matches regardless of leading or trailing text. Using = looks for an exact literal match.',
        ARRAY['sql', 'filtering', 'like']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'WHERE device_name = ''%iPhone 8%'' OR device_name = ''%iPhone 7%''', false),
    (v_q_id, 'B', 'WHERE device_name IN (''%iPhone 8%'', ''%iPhone 7%'')', false),
    (v_q_id, 'C', 'WHERE device_name LIKE ''*iPhone 8*'' OR device_name LIKE ''*iPhone 7*''', false),
    (v_q_id, 'D', 'WHERE device_name LIKE ''%iPhone 8%'' OR device_name LIKE ''%iPhone 7%''', true);

    -- ----------------------------------------
    -- QUESTION 25 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        25,
        'Netflix''s Test Account Filter',
        'Netflix''s PM is doing usage analysis but wants to aggressively filter out internal test accounts. Any account where the email ends specifically with ''@netflix.com'' should be removed. Which filter does this?',
        'intermediate',
        'Netflix',
        'Data cleaning and exclusions',
        'A',
        'The NOT LIKE operator combined with the leading % wildcard successfully removes any string ending in the target text. Using != without wildcards only excludes exact string matches, missing test accounts with prefixes.',
        ARRAY['sql', 'filtering', 'not_like']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'WHERE email NOT LIKE ''%@netflix.com''', true),
    (v_q_id, 'B', 'WHERE email != ''%@netflix.com''', false),
    (v_q_id, 'C', 'WHERE email NOT IN (''@netflix.com'')', false),
    (v_q_id, 'D', 'WHERE NOT LIKE ''%@netflix.com''', false);

    -- ----------------------------------------
    -- QUESTION 26 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        26,
        'Spotify''s INNER JOIN Trap',
        'Spotify''s PM uses an INNER JOIN between the users table and the premium_subscriptions table to see listening habits alongside plan tiers. What silently happens to free users in this result set?',
        'intermediate',
        'Spotify',
        'Understanding join implications',
        'B',
        'An INNER JOIN mandates that a matching key must exist in both tables. Because free users do not exist in the premium_subscriptions table, they are completely dropped from the final output, silently skewing any overall averages.',
        ARRAY['sql', 'joins', 'inner_join']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'They appear with NULL in subscription columns.', false),
    (v_q_id, 'B', 'They are completely excluded from the results.', true),
    (v_q_id, 'C', 'They cause the query to error.', false),
    (v_q_id, 'D', 'They are included if they have been premium in the past.', false);

    -- ----------------------------------------
    -- QUESTION 27 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        27,
        'Uber''s Conditional Bucketing',
        'Uber''s Operations PM wants to bucket drivers into ''High'', ''Medium'', and ''Low'' earners based on their monthly payouts. Which SQL structure allows dynamic categorization of a numeric column?',
        'intermediate',
        'Uber',
        'Cohort building and categorization',
        'C',
        'The CASE WHEN ... THEN ... ELSE ... END statement is SQL''s native way to implement IF/THEN conditional logic. It evaluates each row and applies the defined categorical string bucket. IF statements are not used in standard SELECT queries.',
        ARRAY['sql', 'case_when']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'BUCKET(earnings, 5000, 1000)', false),
    (v_q_id, 'B', 'IF earnings > 5000 THEN ''High'' ELSE ''Low''', false),
    (v_q_id, 'C', 'CASE WHEN earnings > 5000 THEN ''High'' WHEN earnings > 2000 THEN ''Medium'' ELSE ''Low'' END', true),
    (v_q_id, 'D', 'GROUP BY earnings > 5000', false);

    -- ----------------------------------------
    -- QUESTION 28 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        28,
        'Airbnb''s Function Indexing Risk',
        'Airbnb''s PM writes a query to find guests who booked in 2023: WHERE EXTRACT(YEAR FROM booking_date) = 2023. This table has 500 million rows and a B-Tree index on booking_date. What is the performance risk?',
        'intermediate',
        'Airbnb',
        'Query optimization and SARGability',
        'D',
        'Applying a function directly to a column in the WHERE clause generally prevents the database engine from utilizing indexes on that column (violating SARGability). It forces a slow full table scan. You should filter using standard date ranges instead.',
        ARRAY['sql', 'performance', 'indexes']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'YEAR() is not an accurate function for leap years.', false),
    (v_q_id, 'B', 'The query will return dates from 2024 as well.', false),
    (v_q_id, 'C', 'It creates a Cartesian product.', false),
    (v_q_id, 'D', 'Applying a function to the column prevents the database from using the index, causing a full table scan.', true);

    -- ----------------------------------------
    -- QUESTION 29 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        29,
        'Stripe''s Sessionization Strategy',
        'Stripe''s Fraud PM wants to group failed login attempts into a single "session" if they occur within 5 minutes of each other. This requires dynamically assigning a session ID based on time gaps. How is this achieved in SQL?',
        'advanced',
        'Stripe',
        'Fraud detection and event grouping',
        'A',
        'This is a classic sessionization problem. You use LAG() to calculate the time difference from the prior event. You then use a CASE statement to flag differences > 5 mins with a 1. Finally, you use a cumulative SUM() over those flags to increment and assign sequential session IDs.',
        ARRAY['sql', 'sessionization', 'window_functions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use LAG() to calculate time gaps, flag gaps > 5 mins as 1, and use a cumulative SUM() over those flags to create an ID.', true),
    (v_q_id, 'B', 'Use GROUP BY DATE_TRUNC(''minute'', time) and divide the result by 5.', false),
    (v_q_id, 'C', 'Use NTILE(5) over the timeline to evenly chunk events into 5-minute intervals.', false),
    (v_q_id, 'D', 'Use DENSE_RANK() OVER(PARTITION BY time) to automatically bucket the timestamps into sessions.', false);

    -- ----------------------------------------
    -- QUESTION 30 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        30,
        'Slack''s Nested Threads',
        'Slack''s PM wants to export a massive thread where replies have replies, going down up to 10 levels deep. The table has message_id and parent_message_id. How do you traverse this deeply nested hierarchy?',
        'advanced',
        'Slack',
        'Hierarchical data traversal',
        'B',
        'A WITH RECURSIVE CTE is designed specifically for hierarchical or tree-structured data. It contains an anchor member (the root message) and a recursive member that repeatedly joins the table to the CTE itself to traverse deeply nested relationships.',
        ARRAY['sql', 'recursive_ctes']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Write 10 nested LEFT JOINs, one for each potential level of depth.', false),
    (v_q_id, 'B', 'Use a WITH RECURSIVE CTE to iteratively join the table to itself and traverse down the hierarchy.', true),
    (v_q_id, 'C', 'Use the LEAD() window function partitioned by parent_message_id to iterate through the thread.', false),
    (v_q_id, 'D', 'Use GROUP BY ROLLUP(parent_message_id, message_id).', false);

    -- ----------------------------------------
    -- QUESTION 31 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        31,
        'Shopify''s Window Function Limits',
        'Shopify''s PM wants to filter for every user''s second purchase. They try: WHERE ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY date) = 2. The query fails. Why?',
        'advanced',
        'Shopify',
        'Query execution pipeline limits',
        'C',
        'According to SQL logical execution order, window functions are evaluated in the SELECT phase, which happens after the WHERE phase. Therefore, window functions cannot be used directly in WHERE; they must be generated in a CTE or subquery first, and then filtered outside.',
        ARRAY['sql', 'window_functions', 'execution_order']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'ROW_NUMBER() is not supported in filtering logic; you must use RANK().', false),
    (v_q_id, 'B', 'The OVER clause is missing a GROUP BY statement.', false),
    (v_q_id, 'C', 'Window functions are evaluated after the WHERE clause, so they must be wrapped in a CTE or subquery to be filtered.', true),
    (v_q_id, 'D', 'Window functions can only be used on aggregate data like SUM or COUNT.', false);

    -- ----------------------------------------
    -- QUESTION 32 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        32,
        'DoorDash''s Simpson''s Paradox',
        'DoorDash''s PM needs to calculate overall conversion rate. The data engineering team provided a pre-aggregated table with daily_visitors and daily_conversions. The PM runs AVG(daily_conversions / daily_visitors). Why is this mathematically dangerous?',
        'advanced',
        'DoorDash',
        'Statistical pitfalls in analytics',
        'D',
        'Taking an average of averages exposes you to Simpson''s Paradox. A day with 10 total visitors is given the exact same weight as a day with 1,000,000 visitors. You must recalculate the true ratio by using SUM(daily_conversions) / SUM(daily_visitors).',
        ARRAY['sql', 'aggregations', 'simpsons_paradox']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It will return NULL if any single day has 0 visitors, crashing the query.', false),
    (v_q_id, 'B', 'AVG() cannot be used on divided columns; it only works on single integers.', false),
    (v_q_id, 'C', 'It correctly weights the data, but is computationally expensive.', false),
    (v_q_id, 'D', 'It calculates an "average of averages", improperly giving equal weight to low-traffic and high-traffic days.', true);

    -- ----------------------------------------
    -- QUESTION 33 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        33,
        'Tinder''s Division Truncation',
        'Tinder''s PM wants to calculate the right-swipe rate. In PostgreSQL, they write: SUM(right_swipes) / SUM(total_swipes). Both columns are integers. If a user has 80 right swipes and 100 total, the query returns 0. Why?',
        'advanced',
        'Tinder',
        'Data types and integer math',
        'A',
        'In PostgreSQL, dividing two integers defaults to integer division, which aggressively truncates any decimals. 80 / 100 results in 0. To fix this, you must explicitly cast at least one of the integers to a decimal or float (e.g., SUM(right_swipes)::decimal).',
        ARRAY['sql', 'division', 'data_types']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'PostgreSQL defaults to integer division, which truncates any decimal remainders down to zero. You must cast to a decimal.', true),
    (v_q_id, 'B', 'COUNT() simply counts the number of non-null rows, so N / N = 1. They should have used SUM().', false),
    (v_q_id, 'C', 'The columns are perfectly correlated, triggering a statistical redundancy in the query engine.', false),
    (v_q_id, 'D', 'Integer division naturally returns the ceiling value, rounding up.', false);

    -- ----------------------------------------
    -- QUESTION 34 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        34,
        'Figma''s Gaps and Islands',
        'Figma''s PM wants to find power users who edited files for 7 strictly consecutive days. This is known as the "Gaps and Islands" problem. What is the standard window function technique to identify consecutive sequences?',
        'advanced',
        'Figma',
        'Complex sequencing logic',
        'B',
        'Subtracting ROW_NUMBER() from the actual date leverages the parallel linear growth of both variables. For consecutive days, both the date and the row number increase by exactly 1, so their difference yields a constant "anchor" date, successfully grouping the island.',
        ARRAY['sql', 'gaps_and_islands', 'window_functions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use LAG(date, 7) and check if the difference is exactly 7 days.', false),
    (v_q_id, 'B', 'Subtract ROW_NUMBER() OVER(ORDER BY date) from the actual date column. Consecutive days will yield the same constant difference.', true),
    (v_q_id, 'C', 'Group by EXTRACT(WEEK FROM date) and use HAVING COUNT(DISTINCT EXTRACT(DOW FROM date)) = 7.', false),
    (v_q_id, 'D', 'Use SUM(date) OVER(ROWS BETWEEN 6 PRECEDING AND CURRENT ROW).', false);

    -- ----------------------------------------
    -- QUESTION 35 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        35,
        'Notion''s Time Zone Reporting',
        'Notion''s PM wants to aggregate daily active users. Their database stores timestamps purely in UTC. If they group by timestamp::date, what fundamental business reporting issue will they face with their San Francisco headquarters?',
        'advanced',
        'Notion',
        'Timestamp boundaries and local time',
        'C',
        'Casting UTC directly to a date means the "day" flips at midnight UTC (which is 4:00 PM or 5:00 PM Pacific Time). Late afternoon and evening activity in SF will incorrectly roll over into the next calendar day''s metrics, destroying day-over-day accuracy.',
        ARRAY['sql', 'dates', 'timezones']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The database will throw an error because UTC timestamps cannot be cast directly to dates.', false),
    (v_q_id, 'B', 'Daylight saving time changes will cause the entire database to shift by an hour permanently.', false),
    (v_q_id, 'C', 'The metric boundary will flip at midnight UTC, causing evening US activity to incorrectly roll into the next day.', true),
    (v_q_id, 'D', 'PostgreSQL will automatically adjust the timezone based on the IP address of the user running the query.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for SQL';

END $$;
