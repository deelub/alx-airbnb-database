-- ===============================================================
-- USERS
-- ===============================================================

INSERT INTO user_tbl (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
('11111111-1111-1111-1111-111111111111', 'Alice', 'Moyo', 'alice@example.com', 'hashed_pw1', '0712345678', 'host', NOW()),
('22222222-2222-2222-2222-222222222222', 'Brian', 'Nkosi', 'brian@example.com', 'hashed_pw2', '0723456789', 'guest', NOW()),
('33333333-3333-3333-3333-333333333333', 'Chloe', 'Daniels', 'chloe@example.com', 'hashed_pw3', '0734567890', 'guest', NOW()),
('44444444-4444-4444-4444-444444444444', 'David', 'Smith', 'david@example.com', 'hashed_pw4', '0745678901', 'host', NOW()),
('55555555-5555-5555-5555-555555555555', 'Emily', 'Jones', 'emily@example.com', 'hashed_pw5', '0756789012', 'guest', NOW());


-- ===============================================================
-- PROPERTIES
-- ===============================================================

INSERT INTO property_tbl (property_id, host_id, name, description, location, price_per_night, created_at, updated_at)
VALUES
('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111',
 'Cozy Cottage', 'A small peaceful cottage near the lake.', 'Cape Town', 850.00, NOW(), NOW()),

('aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '11111111-1111-1111-1111-111111111111',
 'City Apartment', 'Modern apartment in the city center.', 'Johannesburg', 1200.00, NOW(), NOW()),

('aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3', '44444444-4444-4444-4444-444444444444',
 'Beach House', 'Spacious beachfront villa with pool.', 'Durban', 2500.00, NOW(), NOW());


-- ===============================================================
-- BOOKINGS
-- ===============================================================

INSERT INTO booking_tbl (booking_id, user_id, property_id, start_date, end_date, status, created_at)
VALUES
('bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1',
 '22222222-2222-2222-2222-222222222222',
 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
 '2025-03-01', '2025-03-05', 'confirmed', NOW()),

('bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2',
 '33333333-3333-3333-3333-333333333333',
 'aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3',
 '2025-04-10', '2025-04-15', 'pending', NOW()),

('bbbbbbb3-bbbb-bbbb-bbbb-bbbbbbbbbbb3',
 '55555555-5555-5555-5555-555555555555',
 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2',
 '2025-02-20', '2025-02-22', 'confirmed', NOW());


-- ===============================================================
-- PAYMENTS
-- ===============================================================

INSERT INTO payment_tbl (payment_id, booking_id, amount, payment_method, payment_date)
VALUES
('ccccccc1-cccc-cccc-cccc-ccccccccccc1',
 'bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1',
 3400.00, 'credit_card', NOW()),

('ccccccc2-cccc-cccc-cccc-ccccccccccc2',
 'bbbbbbb3-bbbb-bbbb-bbbb-bbbbbbbbbbb3',
 2400.00, 'eft', NOW());


-- ===============================================================
-- REVIEWS
-- ===============================================================

INSERT INTO review_tbl (review_id, user_id, property_id, rating, comment, created_at)
VALUES
('ddddddd1-dddd-dddd-dddd-ddddddddddd1',
 '22222222-2222-2222-2222-222222222222',
 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
 5, 'Absolutely loved this cottage! Peaceful and relaxing.', NOW()),

('ddddddd2-dddd-dddd-dddd-ddddddddddd2',
 '55555555-5555-5555-5555-555555555555',
 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2',
 4, 'Great apartment, very modern and clean.', NOW());


-- ===============================================================
-- MESSAGES
-- ===============================================================

INSERT INTO message_tbl (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
('eeeeeee1-eeee-eeee-eeee-eeeeeeeeeee1',
 '22222222-2222-2222-2222-222222222222',
 '11111111-1111-1111-1111-111111111111',
 'Hi Alice, I have a question about the cottage availability.', NOW()),

('eeeeeee2-eeee-eeee-eeee-eeeeeeeeeee2',
 '11111111-1111-1111-1111-111111111111',
 '22222222-2222-2222-2222-222222222222',
 'Hi Brian! Sure, feel free to ask anytime.', NOW()),

('eeeeeee3-eeee-eeee-eeee-eeeeeeeeeee3',
 '33333333-3333-3333-3333-333333333333',
 '44444444-4444-4444-4444-444444444444',
 'Hi David, is the Beach House available for early April?', NOW());
