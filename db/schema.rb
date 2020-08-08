# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_08_031647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "egresos", force: :cascade do |t|
    t.text "diagnostico_egreso"
    t.text "observaciones_egreso"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "interno_id", null: false
    t.date "fecha_egreso"
    t.index ["interno_id"], name: "index_egresos_on_interno_id"
  end

  create_table "ingresos", force: :cascade do |t|
    t.datetime "fecha_hora"
    t.boolean "referido_institucion"
    t.string "institucion_referencia"
    t.boolean "hoja_referencia"
    t.string "tipo_ingreso"
    t.text "motivo_ingreso"
    t.text "descripcion_estado_salud"
    t.boolean "hombre"
    t.boolean "mayor_edad"
    t.boolean "dependencias"
    t.boolean "consecuencias"
    t.boolean "transtorno_mental"
    t.boolean "cumple"
    t.text "referirlo"
    t.string "nombre_entrevistador"
    t.string "cargo_entrevistador"
    t.bigint "interno_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["interno_id"], name: "index_ingresos_on_interno_id"
  end

  create_table "internos", force: :cascade do |t|
    t.string "nombre"
    t.string "ap_paterno"
    t.string "ap_materno"
    t.date "fecha_nacimiento"
    t.string "calle"
    t.string "numero"
    t.string "interior"
    t.string "colonia"
    t.string "municipio"
    t.string "estado"
    t.string "telefono_fijo"
    t.string "telefono_celular"
    t.string "telefono_otro"
    t.string "nacionalidad"
    t.string "estado_civil"
    t.string "escolaridad"
    t.string "ocupacion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "motivo_salidas", force: :cascade do |t|
    t.text "descripcion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "parientes", force: :cascade do |t|
    t.string "nombre"
    t.string "ap_paterno"
    t.string "ap_materno"
    t.date "fecha_nacimiento"
    t.string "ocupacion"
    t.string "parentesco"
    t.string "calle"
    t.string "numero"
    t.string "interior"
    t.string "colonia"
    t.string "municipio"
    t.string "estado"
    t.string "telefono_fijo"
    t.string "telefono_celular"
    t.string "telefono_recados"
    t.bigint "interno_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["interno_id"], name: "index_parientes_on_interno_id"
  end

  create_table "tipo_tratamientos", force: :cascade do |t|
    t.text "descripcion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tratamientos", force: :cascade do |t|
    t.date "fecha_inicio"
    t.date "fecha_fin"
    t.integer "total_horas"
    t.text "observaciones"
    t.bigint "interno_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nombre_tratamiento"
    t.index ["interno_id"], name: "index_tratamientos_on_interno_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "usuario"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "roles"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "egresos", "internos"
  add_foreign_key "ingresos", "internos"
  add_foreign_key "parientes", "internos"
  add_foreign_key "tratamientos", "internos"
end
