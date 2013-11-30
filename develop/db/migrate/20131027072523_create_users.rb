#encoding: utf-8
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name                        ,:null => false
      t.string  :user_id                 ,:null => false
      t.string  :nickname                 ,:null => false
      t.string  :password                 ,:null => false
      t.string  :email                 ,:null => false
      t.string  :phone_number                 ,:null => false
      t.string  :city                  ,:null => false
      t.string  :county                ,:null => false
      t.string  :address_detail
      t.integer :field                   ,:default => 0
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
      t.string  :vet_number                 
      t.string  :student_number           
      t.string  :work_name        
      t.string  :work_number           
      t.string  :university            
      t.boolean :mail_receive                 ,:default => false
      t.boolean :sms_receive                 ,:default => false
      t.boolean :exit_flag                 ,:default => false
      t.integer :level                 ,:default => 1
      t.string  :token                 ,:null => false
      t.string  :dummy1                
      t.string  :dummy2                
      t.string  :dummy3                
      t.string  :dummy4                
      t.string  :dummy5                
      t.timestamps
    end
  end
end
