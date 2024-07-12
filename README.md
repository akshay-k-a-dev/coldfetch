<p>coldfetch (Pre-release)</p>
<p>coldfetch is a Bash script to fetch and display system information in a colorful and informative way.</p>
<p>Features</p>
<ul>
<li>Displays detailed system information including OS, kernel, uptime, terminal, shell, CPU, memory, GPU, storage, and more.</li>
<li>Supports various Linux distributions and hardware configurations.</li>
<li>Easy installation and setup.</li>
</ul>
<p>Installation</p>
<p>Prerequisites</p>
<ul>
<li>bash</li>
<li>coreutils</li>
<li>util-linux</li>
<li>procps</li>
<li>dmidecode</li>
<li>lm-sensors</li>
<li>sudo</li>
<li>hdparm</li>
</ul>
<p>Installation Steps</p>
<ol>
<li>Clone the repository:</li>
</ol>
<p>bash</p>
<li><p>git clone <a href="https://github.com/Akshay-code-space/coldfetch">https://github.com/Akshay-code-space/coldfetch</a></p></li>
<li><p>cd coldfetch</p></li>
<ol>
<li>Run the installation script:</li>
</ol>
<p>bash</p>
<li><p>chmod +x install.sh</li>
./install.sh</p>
<p>Follow the on-screen prompts to install dependencies and configure coldfetch.</p>
<ol>
<li>Refresh your shell configuration:</li>
</ol>
<p>bash</p>
<li>source ~/.bashrc</li>
<li>or ~/.zshrc for zsh users</li><br>
<p>Usage</p>
<p>To display system information, simply run coldfetch in your terminal:</p>
<p>bash</p>
<li>coldfetch</li><br>
<p>This will fetch and display detailed system information in a clear and readable format.</p>
<p>Script Details</p>
<p>coldfetch Script Overview</p>
<p>The coldfetch script is designed to gather and present system details using various Linux command-line utilities:</p>
<ul>
<li>OS Details: Fetches the name and version of the operating system.</li>
<li>Kernel Details: Retrieves the kernel version currently running.</li>
<li>Uptime: Shows how long the system has been running since last boot.</li>
<li>Terminal: Displays the terminal emulator being used.</li>
<li>Shell: Shows the default shell and its version.</li>
<li>CPU Details: Retrieves CPU model, number of cores, and current frequency.</li>
<li>CPU Fan Speed: Fetches CPU fan speed if available.</li>
<li>Memory Details: Shows total memory, used memory, and available memory.</li>
<li>RAM Speed: Retrieves RAM speed in MHz.</li>
<li>GPU Details: Displays GPU details including temperature, fan speed, clock speed, and VRAM usage.</li>
<li>Storage Details: Lists storage devices along with their sizes and models.</li>
<li>Distribution: Displays the distribution name of the OS.</li>
<li>Package Manager: Shows the package manager and its version.</li>
<li>Number of Packages: Displays the total number of installed packages.</li>
<li>Screen Resolution: Retrieves the current screen resolution.</li>
<li>Language: Shows the system language.</li>
</ul>
<p>Testing</p>
<p>This version of coldfetch is a pre-release. Testers and contributors are welcomed to try it out, provide feedback, and report any issues on GitHub.</p>
<p>Contributing</p>
<p>Contributions are welcome! Feel free to fork the repository, make your changes, and submit a pull request.</p>
<p>License</p>
<p>This project is licensed under the GNU General Public License v3.0. See the LICENSE file for details.</p>
<p>Author</p>
<ul>
<li>GitHub: (<a href="https://github.com/Akshay-code-space">Auther</a>)</li>
</ul>
<p>Acknowledgments</p>
<ul>
<li>Inspiration and some code snippets from various open-source projects.</li>
<li>Special thanks to contributors and testers.</li>
</ul>
