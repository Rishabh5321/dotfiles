import { Octokit } from "@octokit/rest";

// This would be used in the build process to fetch actual files from GitHub
export async function fetchRepositoryFiles(owner, repo, path = '') {
  const octokit = new Octokit({
    auth: process.env.GITHUB_TOKEN,
  });

  async function getContent(path) {
    const response = await octokit.repos.getContent({
      owner,
      repo,
      path,
    });
    
    return response.data;
  }

  async function processDirectory(dirPath) {
    const contents = await getContent(dirPath);
    const result = [];
    
    for (const item of contents) {
      if (item.type === 'dir') {
        const subItems = await processDirectory(item.path);
        result.push(...subItems);
      } else if (item.type === 'file' && item.name.endsWith('.nix')) {
        // Only process .nix files
        const fileContent = await octokit.request(item.download_url);
        result.push({
          name: item.name,
          path: item.path,
          content: Buffer.from(fileContent.data).toString('utf8'),
        });
      }
    }
    
    return result;
  }

  // Start the recursive processing from the given path
  const files = await processDirectory(path);
  
  // Organize files by host
  const hosts = [];
  const commonFiles = [];
  
  // Process the nixos directory to find hosts
  const nixosFiles = files.filter(file => file.path.startsWith('nixos/'));
  const hostNames = new Set();
  
  for (const file of nixosFiles) {
    const pathParts = file.path.split('/');
    if (pathParts.length >= 3) {
      const hostName = pathParts[1];
      hostNames.add(hostName);
    }
  }
  
  // Create host objects
  for (const hostName of hostNames) {
    const hostFiles = nixosFiles.filter(file => file.path.includes(`nixos/${hostName}/`));
    hosts.push({
      name: hostName,
      description: `NixOS configuration for ${hostName}`,
      files: hostFiles,
    });
  }
  
  // Add common files
  for (const file of files) {
    if (!file.path.startsWith('nixos/')) {
      commonFiles.push(file);
    }
  }
  
  return { hosts, commonFiles };
}