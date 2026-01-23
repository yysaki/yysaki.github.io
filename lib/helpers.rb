# frozen_string_literal: true

# rubocop:disable Style/MixinUsage

# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
#

include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::XMLSitemap

# rubocop:enable Style/MixinUsage
