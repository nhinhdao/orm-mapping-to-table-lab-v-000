require'pry'
class Student
    # Remember, you can access your database connection anywhere in this class
    #  with DB[:conn]
    attr_accessor :name, :grade
    attr_reader :id

    def initialize(name, grade, id = nil)
        @id, @name, @grade = id, name, grade
    end

    def self.create_table
        sql = <<-SQL
        CREATE TABLE students
        (id integer primary key, name text, grade text)
        SQL
        DB[:conn].execute(sql)
    end

    def save
        sql = <<-SQL
        INSERT INTO students (name, grade) values (?,?)
        SQL
        DB[:conn].execute(sql, self.name, self.grade)
        @id = DB[:conn].execute("select * from students")[0][0]
    end

    def self.drop_table
        sql = <<-SQL
        DROP TABLE students
        SQL
        DB[:conn].execute(sql)
    end

    def self.create(student_hash)
        # binding.pry
        student = self.new(student_hash.values[0], student_hash.values[1])
        student.save

        student
    end
end
