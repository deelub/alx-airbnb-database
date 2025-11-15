-- =====================================================================
-- USER_TBL
-- =====================================================================
CREATE TABLE user_tbl (
    user_id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name     VARCHAR(100) NOT NULL,
    last_name      VARCHAR(100) NOT NULL,
    email          VARCHAR(255) UNIQUE NOT NULL,
    password_hash  TEXT NOT NULL,
    phone_number   VARCHAR(20),
    role           VARCHAR(20) CHECK (role IN ('guest', 'host', 'admin')),
    created_at     TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_user_email ON user_tbl (email);
CREATE INDEX idx_user_role  ON user_tbl (role);


-- =====================================================================
-- PROPERTY_TBL
-- =====================================================================
CREATE TABLE property_tbl (
    property_id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    host_id         UUID NOT NULL,
    name            VARCHAR(255) NOT NULL,
    description     TEXT,
    location        VARCHAR(255) NOT NULL,
    price_per_night NUMERIC(10,2) NOT NULL CHECK (price_per_night >= 0),
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP NOT NULL DEFAULT NOW(),

    FOREIGN KEY (host_id) REFERENCES user_tbl(user_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_property_host_id ON property_tbl (host_id);
CREATE INDEX idx_property_location ON property_tbl (location);


-- =====================================================================
-- BOOKING_TBL
-- =====================================================================
CREATE TABLE booking_tbl (
    booking_id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id      UUID NOT NULL,
    property_id  UUID NOT NULL,
    start_date   DATE NOT NULL,
    end_date     DATE NOT NULL,
    status       VARCHAR(20) CHECK (status IN ('pending', 'confirmed', 'cancelled')),
    created_at   TIMESTAMP NOT NULL DEFAULT NOW(),

    -- Derived field optional
    -- total_price NUMERIC(10,2),

    FOREIGN KEY (user_id) REFERENCES user_tbl(user_id)
        ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES property_tbl(property_id)
        ON DELETE CASCADE
);

-- Ensures valid booking dates
ALTER TABLE booking_tbl 
    ADD CONSTRAINT chk_booking_dates CHECK (end_date > start_date);

CREATE INDEX idx_booking_user_id ON booking_tbl (user_id);
CREATE INDEX idx_booking_property_id ON booking_tbl (property_id);
CREATE INDEX idx_booking_dates ON booking_tbl (start_date, end_date);


-- =====================================================================
-- PAYMENT_TBL
-- =====================================================================
CREATE TABLE payment_tbl (
    payment_id    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id    UUID NOT NULL,
    amount        NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    payment_method VARCHAR(50) NOT NULL,
    payment_date  TIMESTAMP NOT NULL DEFAULT NOW(),

    FOREIGN KEY (booking_id) REFERENCES booking_tbl(booking_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_payment_booking_id ON payment_tbl (booking_id);
CREATE INDEX idx_payment_date        ON payment_tbl (payment_date);


-- =====================================================================
-- REVIEW_TBL
-- =====================================================================
CREATE TABLE review_tbl (
    review_id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id     UUID NOT NULL,
    property_id UUID NOT NULL,
    rating      INT CHECK (rating BETWEEN 1 AND 5),
    comment     TEXT,
    created_at  TIMESTAMP NOT NULL DEFAULT NOW(),

    FOREIGN KEY (user_id) REFERENCES user_tbl(user_id)
        ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES property_tbl(property_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_review_property ON review_tbl (property_id);
CREATE INDEX idx_review_user     ON review_tbl (user_id);
CREATE INDEX idx_review_rating   ON review_tbl (rating);


-- =====================================================================
-- MESSAGE_TBL
-- =====================================================================
CREATE TABLE message_tbl (
    message_id    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id     UUID NOT NULL,
    recipient_id  UUID NOT NULL,
    message_body  TEXT NOT NULL,
    sent_at       TIMESTAMP NOT NULL DEFAULT NOW(),

    FOREIGN KEY (sender_id) REFERENCES user_tbl(user_id)
        ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES user_tbl(user_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_message_sender    ON message_tbl (sender_id);
CREATE INDEX idx_message_recipient ON message_tbl (recipient_id);
CREATE INDEX idx_message_sent_at   ON message_tbl (sent_at);
