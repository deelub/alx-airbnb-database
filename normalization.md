# Database Normalization to Third Normal Form (3NF)

This document describes the normalization process applied to the database schema shown in the ER diagram. The final schema achieves Third Normal Form (3NF), with only optional exceptions for performance-related derived values.

---

## 1. First Normal Form (1NF)

### Requirements
- Each table has a primary key.
- All attributes contain atomic (indivisible) values.
- No repeating groups or multivalued attributes.

### Result
All tables meet 1NF:
- User, Property, Booking, Payment, Review, and Message tables contain only atomic fields.
- No repeating columns (e.g., phone1, phone2).
- All tables have a clearly defined primary key.

---

## 2. Second Normal Form (2NF)

### Requirements
- The schema is in 1NF.
- No partial dependencies (non-key attributes depending on part of a composite key).

### Result
All tables use single-column primary keys.  
Therefore, partial dependency is impossible.

The schema meets all 2NF requirements.

---

## 3. Third Normal Form (3NF)

### Requirements
- The schema is in 2NF.
- No transitive dependencies (non-key attributes depending on other non-key attributes).
- No derived attributes stored unless intentionally denormalized.

### Issues Identified

#### 3.1 BOOKING_TBL.total_price
- `total_price` can be calculated from:
  - `PROPERTY_TBL.price_per_night`
  - `start_date` and `end_date`
- This makes it a *derived attribute*, so storing it violates strict 3NF.

**Resolution:**  
- The field may be removed to maintain pure 3NF,  
  **or**  
- retained as an intentional denormalization for performance.

#### 3.2 PAYMENT_TBL.amount
- If the system supports only full payments equal to the booking price, this is also derived.
- If partial payments are allowed, then the attribute is valid.

**Resolution:**  
- Keep only if partial payments are supported.

---

## 4. Final 3NF-Compliant Schema (After Adjustments)

### USER_TBL
- user_id (PK)  
- first_name  
- last_name  
- email  
- password_hash  
- phone_number  
- role  
- created_at  

### PROPERTY_TBL
- property_id (PK)  
- host_id (FK)  
- name  
- description  
- location  
- price_per_night  
- created_at  
- updated_at  

### BOOKING_TBL
- booking_id (PK)  
- user_id (FK)  
- property_id (FK)  
- start_date  
- end_date  
- status  
- created_at  
*(Optional: total_price — denormalization)*

### PAYMENT_TBL
- payment_id (PK)  
- booking_id (FK)  
- payment_method  
- payment_date  
- amount *(optional—only if partial payments are allowed)*

### REVIEW_TBL
- review_id (PK)  
- user_id (FK)  
- property_id (FK)  
- rating  
- comment  
- created_at  

### MESSAGE_TBL
- message_id (PK)  
- sender_id (FK)  
- recipient_id (FK)  
- message_body  
- sent_at  

---

## 5. Conclusion

The database schema satisfies the requirements for:
- **1NF** (atomic values, primary keys, no repeating groups)
- **2NF** (no partial dependencies)
- **3NF** (no transitive dependencies)

Only two optional attributes (`total_price` and `amount`) could violate strict 3NF, and both may be retained intentionally for performance or business logic reasons.

The final schema is therefore fully normalized to **Third Normal Form (3NF)**.
