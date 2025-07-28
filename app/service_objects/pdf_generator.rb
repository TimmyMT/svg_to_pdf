class PdfGenerator
  attr_reader :svg_path, :pdf_path, :svg_data

  def initialize(svg_path:)
    @svg_path = svg_path
    @pdf_path = "tmp/cache/output#{DateTime.now.to_s}.pdf"

    @svg_data = File.read(svg_path)
  end

  def call
    Prawn::Document.generate(pdf_path, page_size: 'A4') do |pdf|
      pdf.svg svg_data, at: [0, pdf.cursor], width: 500

      # Получаем размеры страницы
      page_width  = pdf.bounds.width
      page_height = pdf.bounds.height

      watermark_text = "Timur Karimov"
      font_size = 48

      # Установим стиль
      pdf.fill_color "000000"
      pdf.font_size font_size

      # Размер прямоугольника для watermark'а
      box_width = 400
      box_height = 50

      x = (page_width - box_width) / 2
      y = (page_height + box_height) / 1.5 # +box_height чтобы текст был по центру

      pdf.transparent(0.2) do
        pdf.text_box watermark_text,
          at: [x, y],
          width: box_width,
          height: box_height,
          align: :center,
          valign: :center,
          size: font_size,
          rotate: 45,
          rotate_around: :center
      end
    end
  end
end
