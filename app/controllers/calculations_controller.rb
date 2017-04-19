class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.length

    text_wo_spaces = @text.gsub(" ","")
    text_wo_linefeed = text_wo_spaces.gsub("\n","")
    text_wo_cr = text_wo_linefeed.gsub("\r","")
    text_wo_tabs = text_wo_cr.gsub("\t","")


    @word_count = @text.split.length

    @character_count_without_spaces = text_wo_tabs.length

    a = @text


    @occurrences = a.split.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================


    @monthly_payment = @principal*(@apr/1200)/(1-((1+@apr/1200)**-(@years*12)))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52.14

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count
    
    @minimum = @sorted_numbers. fetch(0)

    @maximum = @sorted_numbers.max

    @range = @maximum-@minimum

    len = @sorted_numbers.length
    @median = (@sorted_numbers[(len -1)/2] + @sorted_numbers[len/2])/2.0

    @sum = @numbers.sum

    @mean = @numbers.sum/@count


    mean = @mean
    numbers = @numbers
    squared_sum =  []

    @numbers.each do |num|
      square_diff = (num - mean)*(num - mean)
      squared_sum.push(square_diff)
    end

    @variance = squared_sum.sum/@count

    @standard_deviation = Math.sqrt(@variance)



    freq = numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    @mode = numbers.max_by { |v| freq[v] }


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
