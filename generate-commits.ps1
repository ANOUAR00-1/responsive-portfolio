# Git Commit Generator Script
# Generates 30 commits starting from January 2, 2024

$startDate = Get-Date "2024-01-02"
$numberOfCommits = 30

$commitMessages = @(
    "Initial project setup",
    "Add hero section structure",
    "Update navigation styles",
    "Implement responsive design",
    "Add contact form",
    "Update color scheme",
    "Fix mobile menu",
    "Add animation effects",
    "Update footer content",
    "Improve accessibility",
    "Add social media links",
    "Update hero image",
    "Fix responsive issues",
    "Add services section",
    "Update about section",
    "Improve performance",
    "Add smooth scrolling",
    "Update typography",
    "Fix button styles",
    "Add hover effects",
    "Update gradient colors",
    "Improve SEO",
    "Add meta tags",
    "Update contact info",
    "Fix form validation",
    "Add loading animations",
    "Update documentation",
    "Improve code structure",
    "Add comments",
    "Final polish and cleanup"
)

$filesToModify = @(
    "style.css",
    "index.htm",
    "script.js",
    "README.md"
)

Write-Host "Starting Git Commit Generator..." -ForegroundColor Cyan
Write-Host "Start Date: $($startDate.ToString('yyyy-MM-dd'))" -ForegroundColor Yellow
Write-Host "Number of Commits: $numberOfCommits" -ForegroundColor Yellow
Write-Host ""

if (-not (Test-Path ".git")) {
    Write-Host "No git repository found. Initializing..." -ForegroundColor Yellow
    git init
    Write-Host "Git repository initialized!" -ForegroundColor Green
    Write-Host ""
}

for ($i = 0; $i -lt $numberOfCommits; $i++) {
    $daysToAdd = $i * (Get-Random -Minimum 1 -Maximum 3)
    $hoursToAdd = Get-Random -Minimum 9 -Maximum 20
    $minutesToAdd = Get-Random -Minimum 0 -Maximum 59
    
    $commitDate = $startDate.AddDays($daysToAdd).AddHours($hoursToAdd).AddMinutes($minutesToAdd)
    $formattedDate = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
    
    $message = $commitMessages[$i % $commitMessages.Length]
    
    $fileToModify = $filesToModify | Get-Random
    
    if (Test-Path $fileToModify) {
        $timestamp = Get-Date -Format "yyyyMMddHHmmss"
        Add-Content -Path $fileToModify -Value "`n/* Updated: $timestamp */" -NoNewline
        
        git add $fileToModify
        
        $env:GIT_AUTHOR_DATE = $formattedDate
        $env:GIT_COMMITTER_DATE = $formattedDate
        
        git commit -m $message --date="$formattedDate"
        
        Remove-Item Env:\GIT_AUTHOR_DATE
        Remove-Item Env:\GIT_COMMITTER_DATE
        
        Write-Host "Commit $($i + 1)/$numberOfCommits : $message" -ForegroundColor Green
        Write-Host "  Date: $formattedDate" -ForegroundColor DarkGray
    }
}

Write-Host ""
Write-Host "Successfully created $numberOfCommits commits!" -ForegroundColor Green
Write-Host "Commit history:" -ForegroundColor Cyan
Write-Host ""

git log --oneline -n 10

Write-Host ""
Write-Host "Tips:" -ForegroundColor Yellow
Write-Host "   - Run git log to see all commits" -ForegroundColor White
Write-Host "   - Run git push to push to remote repository" -ForegroundColor White
Write-Host ""
Write-Host "Done! Your project now has a complete commit history." -ForegroundColor Cyan
