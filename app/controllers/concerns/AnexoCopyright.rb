module AnexoCopyright
	extend ActiveSupport::Concern

	included do
		before_action :set_copyright
	end

	def set_copyright
	@copyright = AnexoCR::Renderer.copyright 'Clínica de Rehabilitación Felipe Neri','Todos los derechos reservados'
  end

  module AnexoCR
	class Renderer
		def self.copyright name, msg
			"&copy; #{Time.now.year} | #{name} | #{msg}".html_safe
		end
	end
end

end