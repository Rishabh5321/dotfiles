{ pkgs-unstable, ... }: {
  environment.systemPackages = with pkgs-unstable; [
    geminicommit # Gemini commit message generator
    gemini-cli # AI
    grayjay # Video platform client
    zed-editor # Editor
  ];
}
