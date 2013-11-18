#encoding: utf-8
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name                        ,:null => false
      t.string  :nickname                 ,:null => false
      t.string  :user_id                 ,:null => false
      t.string  :password                 ,:null => false
      t.string  :email                 ,:null => false
      t.string  :phone_number                 ,:null => false
      t.string  :address                 ,:null => false
      t.integer :field                   ,:null => false 
                        #0=일반회원              
                        #1=수의대생
                        #2=반려동물수의사
                        #3=산업동물수의사
                        #4=야생동물수의사  
                        #5=수의직공무원
                        #6=수의관련업체
                        #7=수의사회
                        #8=수의과대학교직원
                        #9=수의장교
                        #10=공중방역수의사
                        #11=기타
      t.string  :vet_number                 ,:null => false
      t.string  :student_number                 ,:null => false
      t.string  :work_name                 ,:null => false
      t.string  :work_number                 ,:null => false
      t.string  :university                 ,:null => false
      t.boolean :mail_receive                 ,:default => false
      t.boolean :sms_receive                 ,:default => false
      t.boolean :exit_flag                 ,:default => false
      t.integer :level                 ,:default => 1
      t.timestamps
    end
  end
end
