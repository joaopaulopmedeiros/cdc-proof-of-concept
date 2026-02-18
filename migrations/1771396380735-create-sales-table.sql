CREATE TABLE sales (
    id              BIGSERIAL PRIMARY KEY,
    order_id        UUID NOT NULL,
    customer_id     UUID NOT NULL,
    product_id      UUID NOT NULL,
    quantity        INTEGER NOT NULL CHECK (quantity > 0),
    unit_price      NUMERIC(12,2) NOT NULL CHECK (unit_price >= 0),
    total_amount    NUMERIC(14,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    status          VARCHAR(30) NOT NULL DEFAULT 'CREATED',
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ
);
