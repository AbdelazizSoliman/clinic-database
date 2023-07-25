CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name varchar(50) NOT NULL,
  date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT NOT NULL,
  status varchar(50),
  CONSTRAINT fk_patient_id FOREIGN KEY (patient_id) REFERENCES patients (id)
);

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL(10,2),
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  CONSTRAINT fk_medical_history_id FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id)
);

CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL(10,2),
  quantity INT,
  total_price DECIMAL(10,2),
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT fk_invoice_id FOREIGN KEY (invoice_id) REFERENCES invoices (id),
  CONSTRAINT fk_treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments (id)
);

CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type varchar(50) NOT NULL,
  name varchar(50) NOT NULL
);
