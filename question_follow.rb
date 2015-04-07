class QuestionFollow

  def self.all
    results = QuestionDatabase.instance.execute('SELECT * FROM question_follows')
    results.map { |result| QuestionFollow.new(result) }
  end

  def self.find_by_id(id)
    results = QuestionDatabase.instance.execute(<<-SQL, id)

    SELECT
      *
    FROM
      question_follows
    WHERE
      id = ?
    SQL

    QuestionFollow.new(results.first)
  end

  def self.followers_for_question_id(question_id)
    results = QuestionDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.*
    FROM
      question_follows AS qf
    JOIN
      users ON users.id = qf.user_id
    WHERE
      qf.question_id = ?

    SQL

    results.map { |result| User.new(result) }
  end


  attr_reader :id, :question_id, :user_id

  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end



end