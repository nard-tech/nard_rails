class Nard::Rails::Devise::DictionaryService < Nard::Rails::DictionaryMetaService

  DEFAULT_KEY = 'devise.pages'

  def initialize( ref, options, debug_mode: false, default_key: nil )
    super( ref, debug_mode )

    @options = options

    if @debug_mode
      puts "options: #{ @options }"
      puts "key: #{ @key }"
    end

    @seach_common = false
    @default_key ||= DEFAULT_KEY
  end

  def to_s
    @h = h.t( @default_key )
    @key = @default_key.dup

    while dig_hash?
      _key = @key.dup
      @last_attr = @ary.shift

      #-------- 単数形を探索 → 成功

      if @h.keys.include?( @last_attr.to_sym )
        if @h[ @last_attr.to_sym ].instance_of?( Hash ) #---- さらに探索
          @h = @h[ @last_attr.to_sym ]
        else #---- 確定
          @h = nil
        end
        @key += ".#{ @last_attr }"

      #-------- 複数形を探索 → 成功

      elsif @h.keys.include?( @last_attr.pluralize.to_sym )
        if @h[ @last_attr.pluralize.to_sym ].instance_of?( Hash ) #---- さらに探索
          @h = @h[ @last_attr.pluralize.to_sym ]
        else #---- 確定
          @h = nil
        end
        @key += ".#{ @last_attr.pluralize }"

      #-------- 探索失敗
      else
        @h = nil
        @key = nil
      end
    end

    if valid_result?
      h.t( @key, @options )
    elsif @seach_common
      h.t( @ref, @options )
    else
      @ary = @ref.split('.')
      @ary[0] = 'common'
      @ary.delete_at(1)
      if @debug_mode
        puts "common: " + @ary.join('.')
      end
      @seach_common = true
      send(__method__)
    end
  end

  private

  def dig_hash?
    @h.instance_of?( Hash ) and @key.present? and @ary.present?
  end

  def valid_result?
    @h.nil? and @key.present? and @ary.blank?
  end

end
