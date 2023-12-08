CREATE VIEW relatorio_geral AS
SELECT u.id AS user_id,
    u.name AS user_name,
    COUNT(DISTINCT r.id) AS total_revenues,
    COUNT(DISTINCT e.id) AS total_expenses,
    COALESCE(SUM(r.value), 0) AS total_revenue_value,
    COALESCE(SUM(e.value), 0) AS total_expense_value
FROM users u
    LEFT JOIN revenues r ON u.id = r.user_id
    LEFT JOIN expenses e ON u.id = e.user_id
GROUP BY u.id,
    u.name;


CREATE VIEW transacao_por_categorias AS
SELECT 'revenue' AS transaction_type,
    rc.name AS category_name,
    COUNT(r.id) AS transaction_count
FROM revenue_categories rc
    LEFT JOIN revenues r ON rc.id = r.rev_cat_id
GROUP BY rc.name
UNION
SELECT 'expense' AS transaction_type,
    ec.name AS category_name,
    COUNT(e.id) AS transaction_count
FROM expense_categories ec
    LEFT JOIN expenses e ON ec.id = e.ex_cat_id
GROUP BY ec.name;


CREATE VIEW transacao_por_data AS
SELECT 'revenue' AS transaction_type,
    r.id AS transaction_id,
    r.name AS transaction_name,
    r.value AS transaction_value,
    r.purchase_date AS transaction_date
FROM revenues r
UNION
SELECT 'expense' AS transaction_type,
    e.id AS transaction_id,
    e.name AS transaction_name,
    e.value AS transaction_value,
    e.purchase_date AS transaction_date
FROM expenses e;