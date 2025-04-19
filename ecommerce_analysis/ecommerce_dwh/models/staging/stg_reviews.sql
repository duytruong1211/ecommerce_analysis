
with cte as ( select * from {{ source('raw', 'olist_order_reviews') }} )
SELECT
    review_id,
    order_id,
    review_score,
    NULLIF(review_comment_title,'') review_comment_title,
    NULLIF(review_comment_message,'') review_comment_message,
    review_creation_date review_created_at,
    review_answer_timestamp review_answered_at
FROM 
    cte

