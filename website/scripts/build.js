// This script would be run during the GitHub Action build process
// to fetch repository content and prepare it for the static site generation

const { fetchRepositoryFiles } = require('../lib/github');
const fs = require('fs');
const path = require('path');

async function main() {
  try {
    console.log('Fetching repository content...');
    
    // Get the repository owner and name from env vars or hardcode for your repo
    const owner = process.env.REPO_OWNER || 'Rishabh5321';
    const repo = process.env.REPO_NAME || 'dotfiles';
    
    const { hosts, commonFiles } = await fetchRepositoryFiles(owner, repo);
    
    // Create data directory if it doesn't exist
    const dataDir = path.join(process.cwd(), 'data');
    if (!fs.existsSync(dataDir)) {
      fs.mkdirSync(dataDir, { recursive: true });
    }
    
    // Write the data to a JSON file that can be imported by getStaticProps
    fs.writeFileSync(
      path.join(dataDir, 'repo-content.json'),
      JSON.stringify({ hosts, commonFiles }, null, 2)
    );
    
    console.log('Repository content fetched and saved successfully!');
    console.log(`Found ${hosts.length} hosts and ${commonFiles.length} common files.`);
    
    // You could add more build steps here if needed
    
  } catch (error) {
    console.error('Error fetching repository content:', error);
    process.exit(1);
  }
}

main();