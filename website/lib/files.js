import fs from 'fs'
import path from 'path'
import { promisify } from 'util'

const readFile = promisify(fs.readFile)
const readdir = promisify(fs.readdir)
const stat = promisify(fs.stat)

// This would typically run at build time to generate static content
// In a real implementation, we'd use GitHub API or git commands to read from the repo
// For demonstration, we're simulating file reading functions

export async function getConfigFiles() {
  // In a real implementation, these would be read from the repo
  const hosts = [
    {
      name: 'redmi',
      description: 'Configuration for Redmi laptop',
      files: [
        {
          name: 'configuration.nix',
          path: 'nixos/redmi/configuration.nix',
          content: '# This file would contain the actual config content from GitHub'
        },
        {
          name: 'home.nix',
          path: 'nixos/redmi/home.nix',
          content: '# This file would contain the actual home-manager config from GitHub'
        }
      ]
    },
    {
      name: 'dell',
      description: 'Configuration for Dell server',
      files: [
        {
          name: 'configuration.nix',
          path: 'nixos/dell/configuration.nix',
          content: '# This file would contain the actual config content from GitHub'
        },
        {
          name: 'home.nix',
          path: 'nixos/dell/home.nix',
          content: '# This file would contain the actual home-manager config from GitHub'
        }
      ]
    }
  ]

  const commonFiles = [
    {
      name: 'flake.nix',
      path: 'flake.nix',
      content: '# This file would contain the actual flake.nix content from GitHub'
    },
    {
      name: 'overlays/default.nix',
      path: 'overlays/default.nix',
      content: '# This file would contain the overlays configuration'
    }
  ]

  return {
    hosts,
    commonFiles
  }
}

// In a real implementation, we would use the GitHub API to fetch the content
export async function fetchRepoContent() {
  // Implementation would use fetch or octokit to get repository contents
  // For example:
  // const response = await fetch('https://api.github.com/repos/Rishabh5321/dotfiles/contents');
  // return await response.json();
}

// Function to parse a NixOS configuration file and extract comments/documentation
export async function parseNixFile(content) {
  // A simple parser could extract comments and structure
  const lines = content.split('\n')
  const sections = []
  let currentSection = { name: 'Main', content: [], description: '' }
  
  for (const line of lines) {
    if (line.startsWith('# ===')) {
      // New section header
      if (currentSection.content.length > 0) {
        sections.push(currentSection)
      }
      const sectionName = line.replace(/# ===|===/g, '').trim()
      currentSection = { name: sectionName, content: [], description: '' }
    } else if (line.startsWith('# ')) {
      // Comment line - could be a description
      currentSection.description += line.substring(2) + ' '
    } else {
      // Regular content
      currentSection.content.push(line)
    }
  }
  
  // Add the last section
  if (currentSection.content.length > 0) {
    sections.push(currentSection)
  }
  
  return sections
}