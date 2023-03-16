class CreateFacultyAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :faculty_appointments do |t|
      t.integer :employee_id
      t.string :name
      t.integer :department_id
      t.integer :title_code
      t.integer :step
      t.string :appointment_period

      t.timestamps
    end
  end
end
