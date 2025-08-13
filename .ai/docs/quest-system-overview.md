# Quest System Overview

## Purpose and Role

The quest system serves as a guided progression mechanism within the idle game, providing structured objectives that introduce players to game mechanics and reward completion with resources, coins, and experience. Unlike the continuous activity system where players actively choose what to perform, quests provide discrete, time-limited challenges that enhance the idle gameplay loop.

## Medical School Theme Integration

Within the medical school theme, quests represent:
- **Academic Assignments**: Research projects, lab reports, study groups
- **Clinical Challenges**: Patient case studies, diagnostic exercises
- **Professional Development**: Ethics scenarios, research participation
- **Skill Demonstrations**: Practical examinations, presentations

## Core Architecture

The quest system is built around several key components:

### QuestKind Union Type
Defines all available quest types in the game. Each quest kind represents a specific challenge or objective that players can undertake.

### Quest Record Type
Contains all quest instance data:
- **questKind**: The specific type of quest
- **progress**: Current completion status and metrics
- **timeStarted**: When the quest began (for time-limited quests)
- **requirements**: Resources, skills, or other prerequisites needed
- **rewards**: What the player receives upon completion

### Quest Status Lifecycle
```
Available → InProgress → Completed
     ↑           ↓
     ←── Failed ←─
```

- **Available**: Quest can be started by the player
- **InProgress**: Player is actively working on the quest
- **Completed**: Quest finished successfully, rewards granted
- **Failed**: Quest abandoned or time expired (returns to Available)

## Integration with Core Game Systems

### Resource System Integration
- **Requirements**: Quests can require specific resources to begin or complete
- **Consumption**: Resources may be consumed during quest progression
- **Rewards**: Successful completion grants resource rewards

### Coin System Integration
- **Entry Costs**: Some quests may require coin payment to begin
- **Rewards**: Most quests provide coin rewards upon completion
- **Scaling**: Reward amounts scale with quest difficulty and player progression

### Activity System Relationship
- **Complementary**: Quests run alongside regular activities
- **Resource Sharing**: Both systems draw from the same resource pools
- **Progress Tracking**: Quest progress may be tied to activity completion

### Experience System Integration
- **Skill XP Rewards**: Quests grant experience in relevant skills
- **Mastery XP**: Some quests may provide mastery experience for specific activities
- **Progressive Unlocking**: Higher-level quests unlock as skills advance

## Game State Management

### Frontend State
- **Active Quests**: Currently in-progress quests display in UI
- **Available Quests**: Quests player can start show in quest log
- **Progress Indicators**: Visual feedback on quest completion status

### Backend State
- **Quest Records**: Persistent storage of all quest data per game
- **Time Tracking**: Server-side timer management for time-limited quests
- **Validation**: Server validates quest completion and reward distribution

### State Synchronization
- **Real-time Updates**: Quest progress updates immediately across client/server
- **Offline Progress**: Time-based quest progress continues when player offline
- **Conflict Resolution**: Server authoritative for all quest state changes

## Performance Considerations

### Memory Efficiency
- **Lazy Loading**: Quest definitions loaded only when needed
- **State Compression**: Minimal data structures for quest tracking
- **Cleanup**: Completed quests archived to prevent memory bloat

### Computation Optimization
- **Batch Processing**: Quest progress updates processed in batches
- **Caching**: Quest requirements and rewards cached for fast access
- **Incremental Updates**: Only changed quest data synchronized

## Future Extensibility

The quest system architecture supports:
- **Dynamic Quest Generation**: Procedural quest creation based on player state
- **Quest Chains**: Multi-part quests that unlock in sequence
- **Conditional Rewards**: Variable rewards based on completion criteria
- **Social Quests**: Multi-player collaborative objectives
- **Seasonal Events**: Time-limited special quest categories

This foundation provides a robust framework for expanding quest complexity while maintaining the simple, engaging idle game experience.