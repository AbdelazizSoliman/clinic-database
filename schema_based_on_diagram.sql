CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name varchar(50) NOT NULL,
  date_of_birth DATE NOT NULL
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

CREATE TABLE medical_history_treatments (
  medical_history_id INT,
  treatment_id INT,
  PRIMARY KEY (medical_history_id, treatment_id),
  CONSTRAINT fk_medical_history_id FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id),
  CONSTRAINT fk_treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments (id)
);

CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT NOT NULL,
  status varchar(50),
  CONSTRAINT fk_patient_id FOREIGN KEY (patient_id) REFERENCES patients (id)
);

-- Create indexes on foreign key columns
CREATE INDEX idx_invoice_items_invoice_id ON invoice_items (invoice_id);
CREATE INDEX idx_invoice_items_treatment_id ON invoice_items (treatment_id);
CREATE INDEX idx_invoices_medical_history_id ON invoices (medical_history_id);
CREATE INDEX idx_medical_histories_patient_id ON medical_histories (patient_id);
CREATE INDEX idx_medical_history_treatments_medical_history_id ON medical_history_treatments (medical_history_id);
CREATE INDEX idx_medical_history_treatments_treatment_id ON medical_history_treatments (treatment_id);