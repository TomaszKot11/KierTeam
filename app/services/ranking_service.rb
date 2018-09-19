# TODO: not yet implemented
class RankingService

  def initialize(results)
    @results = results
  end

  def call(results)
    @results.order(views: :desc)
  end

    private

    # def lcs_length
    #     lengths = Array.new(a.length){Array.new(b.length, 0)}
    #     greatestLength = 0
    #     output = ''
    #     a.each_char.with_index do |x,i|
    #       b.each_char.with_index do |y,j|
    #         next if x != y
    #         lengths[i][j] = (i.zero? || j.zero?) ? 1 : lengths[i-1][j-1] + 1
    #         if lengths[i][j] > greatestLength
    #           greatestLength = lengths[i][j]
    #           output = a[i - greatestLength + 1, greatestLength]
    #         end
    #       end
    #     end
    #     output.length
    # end
# end
end
