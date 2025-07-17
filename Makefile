# Copyright Layer5, Inc.
#
# Licensed under the GNU Affero General Public License, Version 3.0
# (the # "License"); you may not use this file except in compliance
# with the License. You may obtain a copy of the License at
#
#    https://www.gnu.org/licenses/agpl-3.0.en.html
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include .github/build/Makefile.core.mk
include .github/build/Makefile-show-help.mk

#----------------------------------------------------------------------------
# Academy
# ---------------------------------------------------------------------------
.PHONY: academy-setup academy-dev academy-staging academy-prod update-module

academy-setup:
	 npm i

academy-prod:
	 hugo --gc --minify --baseURL "https://cloud.layer5.io/academy"

academy-staging:
	 hugo --gc --minify --baseURL "https://staging-cloud.layer5.io/academy"

academy-dev:
	hugo build

academy-dev-live:
	hugo serve


update-module:
	@if [ -z "$(module)" ] || [ -z "$(version)" ]; then \
		echo "Usage: make update-module module=<module-path> version=<version>"; \
		exit 1; \
	fi && \
	echo "Updating Hugo module: $(module) to version $(version)" && \
	hugo mod get $(module)@$(version)

sync-with-cloud:
	mkdir -p ../meshery-cloud/academy
	rsync -av --delete public/ ../meshery-cloud/academy/
